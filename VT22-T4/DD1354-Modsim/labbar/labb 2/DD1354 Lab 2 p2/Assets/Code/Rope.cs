using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class Rope : MonoBehaviour
{
    [SerializeField]
    private RopePoint m_ropePointPrefab = null;

    [SerializeField]
    private Transform m_rootPoint = null;

    [SerializeField]
    private Transform[] m_groundPlanes = null;

    [SerializeField]
    private float m_groundStiffness = 800.0f;

    [SerializeField]
    private float m_groundDamping = 5.0f;

    [SerializeField]
    private Transform[] m_spheres = null;

    [SerializeField]
    private float m_sphereStiffness = 800.0f;

    [SerializeField]
    private float m_sphereDamping = 5.0f;

    [SerializeField, Range(2, 200)]
    private int m_numberOfPoints = 10;

    [SerializeField, Range(0.1f, 10.0f)]
    private float m_totalLength = 2.0f;

    [SerializeField]
    private IntegratorType m_integratorType = IntegratorType.Euler;

    [SerializeField]
    private float m_integratorTimeStep = 1.0f / 60.0f;

    [SerializeField, Range(0, 5)]
    private float m_airFriction = 1.0f;

    [SerializeField]
    private Vector3 m_gravity = new Vector3(0, -10, 0);

    [SerializeField]
    private float m_ropeDamping = 7.0f;

    [SerializeField]
    private float m_ropeStiffness = 800.0f;
	
	[SerializeField]
	private bool m_showSimulationPoints = true;

    private int m_previousNumberOfPoints;
    private List<RopePoint> m_points = null;
    private float m_accumulator = 0.0f;
	private bool m_prevShowSimulationPoints = true;
    private Dictionary<IntegratorType, Integrator> m_integrators = new Dictionary<IntegratorType,Integrator>();

	private RopeMesh m_meshGenerator = new RopeMesh();

	void Start ()
    {
        m_integrators.Add(IntegratorType.Euler, new EulerIntegrator());
        m_integrators.Add(IntegratorType.Leapfrog, new LeapfrogIntegrator());
        m_integrators.Add(IntegratorType.RK4, new RK4Integrator());

        RecreateRopePoints();
	}

	void Update () 
    {
        m_accumulator += Mathf.Min(Time.deltaTime / m_integratorTimeStep, 3.0f);

        if (m_previousNumberOfPoints != m_numberOfPoints)
        {
            RecreateRopePoints();
        }

		if (m_showSimulationPoints != m_prevShowSimulationPoints)
		{
			foreach (var pointRenderer in m_points.Select(x=>x.GetComponent<MeshRenderer>()))
				pointRenderer.enabled = m_showSimulationPoints;
			m_prevShowSimulationPoints = m_showSimulationPoints;
		}

        while (m_accumulator > 1.0f)
        {
            m_accumulator -= 1.0f;

            AdvanceSimulation();
        }
		m_meshGenerator.GenerateMesh (GetComponent<MeshFilter>().mesh, m_points.Select(p=>p.transform.localPosition).ToList(), false);
	}

    void ApplyForces(float timeStep)
    {
        ClearAndApplyGravity();
        ApplyGroundForces();
        ApplySphereForces();
        ApplyAirFriction();
        ApplySpringForces();
        ConstraintTopPointToRoot();
    }

    void ClearAndApplyGravity()
    {
        foreach (var point in m_points)
        {
            point.ClearForce();
            point.ApplyForce(m_gravity * point.Mass);
        }
    }

    void ApplyGroundForces()
    {
        if(m_groundPlanes == null)
            return;

        foreach (var ground in m_groundPlanes)
        {
            Vector3 groundNormal = ground.rotation * Vector3.up;

            foreach (var point in m_points)
            {
                Vector3 groundToPoint = point.State.Position - ground.position;
                float distToGround = Vector3.Dot(groundNormal, groundToPoint);
                float radius = point.transform.localScale.x * 0.5f;

                if (distToGround < radius)
                {
                    float penetrationDepth = radius - distToGround;

                    //Spring force outwards
                    point.ApplyForce(m_groundStiffness * penetrationDepth * groundNormal);
                    //Damping
                    point.ApplyForce(-m_groundDamping * point.State.Velocity);
                }
            }
        }
    }

    void ConstraintTopPointToRoot()
    {
        if (m_rootPoint != null)
        {
            m_points[0].State.Velocity = (m_rootPoint.transform.position - m_points[0].State.Position) / m_integratorTimeStep;
        }
    }

    void ApplySphereForces()
    {
        if (m_spheres == null)
            return;

        foreach (var sphere in m_spheres)
        {
            foreach (var point in m_points)
            {
                float sphereRadius = sphere.localScale.x * 0.5f;
                float pointRadius = point.transform.localScale.x * 0.5f;

                Vector3 sphereToPoint = point.State.Position - sphere.position;
                float distance = sphereToPoint.magnitude;

                //Normalize
                sphereToPoint /= distance;
                //Adjust distance for radiuses
                distance -= sphereRadius + pointRadius;

                if (distance < 0)
                {
                    float penetrationDepth = -distance;

                    //Spring force outwards
                    point.ApplyForce(m_sphereStiffness * penetrationDepth * sphereToPoint);
                    //Damping
                    point.ApplyForce(-m_sphereDamping * penetrationDepth * point.State.Velocity);
                }
            }
        }
    }

    void ApplyAirFriction()
    {
        foreach (var point in m_points)
        {
            //Air friction
            point.ApplyForce(-point.State.Velocity * m_airFriction);
        }
    }

    void ApplySpringForces()
    {
        float segmentLength = m_totalLength / (m_numberOfPoints - 1);


        for (int i = 0; i < m_numberOfPoints - 1; i++)
        {
            RopePoint p1 = m_points[i];
            RopePoint p2 = m_points[i + 1];

            //Apply spring force and damping between p1 and p2

            //This is a good place to write your code.
        }
    }

    void RecreateRopePoints()
    {
        if (m_points != null)
        {
            foreach (var point in m_points)
            {
                Destroy(point.gameObject);
            }
        }

        m_points = new List<RopePoint>();
        float segmentLength = m_totalLength / (m_numberOfPoints - 1);

        for (int i = 0; i < m_numberOfPoints; i++)
        {
            RopePoint point = (RopePoint)Instantiate(m_ropePointPrefab, m_rootPoint.position - Vector3.right * i * segmentLength, Quaternion.identity);
            point.transform.parent = transform;
            point.GetComponent<Draggable>().setDragHook(m_rootPoint);
            m_points.Add(point);
        }

        m_previousNumberOfPoints = m_numberOfPoints;
		if (GetComponent<MeshFilter> ().mesh == null)
			GetComponent<MeshFilter> ().mesh = new Mesh ();
		m_meshGenerator.GenerateMesh (GetComponent<MeshFilter>().mesh, m_points.Select(p=>p.transform.localPosition).ToList(), true);
		m_prevShowSimulationPoints = !m_showSimulationPoints; //Make sure points are enabled/disabled
    }

    void AdvanceSimulation()
    {
        m_integrators[m_integratorType].Advance(m_points, ApplyForces, m_integratorTimeStep);
    }
}
