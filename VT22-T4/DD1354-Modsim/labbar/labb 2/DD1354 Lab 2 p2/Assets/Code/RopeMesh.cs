using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;

public class RopeMesh
{
	private int edges = 9;
	private float radius = 0.1f;
	
	List<Vector3> vertices;
	List<int> triangles;
	List<Vector2> uvs;
	bool rebuild;
	float totalDist;
    Vector3 look = new Vector3(23,42,12).normalized;

	/// <summary>
	/// Generates the mesh.
	/// </summary>
	/// <param name="ropeMesh">Rope's mesh.</param>
	/// <param name="points">Points of the mesh, if the list is changed rebuild must be true.</param>
	/// <param name="rebuild">If set to <c>true</c> the triangles are rebuilt as well.</param>
	public void GenerateMesh(Mesh ropeMesh, List<Vector3> points, bool rebuild)
	{
        look = Random.onUnitSphere;

		totalDist = 0;
		this.rebuild = rebuild;
		vertices = new List<Vector3> ();
		triangles = new List<int> ();
		uvs= new List<Vector2> ();
		for (int i=0; i<points.Count-1; i++)
		{	
			Vector3 p0 = (i==0) ? Vector3.up : points[i-1]; //Not used when i==0
			Vector3 p1 = points[i];
			Vector3 p2 = points[i+1];
			Vector3 dir = (i==0) ? (p2-p1) : ((p1-p0).normalized + (p2-p1).normalized);

            if(Vector3.Dot(look, dir) > 0.8f)
                look = Random.onUnitSphere;
			//if the rope direction is parallel with the right vector, strange things happen.
            Quaternion rot = Quaternion.LookRotation(dir, look);
			if (i==0)
			{
				createEdge(p1, rot, false, 0.0f); //Create the top.
			}
			else
			{
				createCircle(p1, rot, (p2-p1).magnitude);
				if (rebuild)
					createTriangles(vertices.Count-edges*2, vertices.Count-edges);
			}
		}
		Vector3 direction = points [points.Count - 1] - points [points.Count - 2];
		//Create the bottom
        createEdge(points[points.Count - 1], Quaternion.LookRotation(direction, look), true, direction.magnitude);

		if (rebuild)
		{
			ropeMesh.Clear ();
			ropeMesh.vertices = vertices.ToArray();
			ropeMesh.triangles = triangles.ToArray();
		}
		else
		{
			ropeMesh.vertices = vertices.ToArray();
		}

		ropeMesh.uv = uvs.ToArray();
		ropeMesh.RecalculateNormals ();
	}

	/// <summary>
	/// Creates the top and bottom.
	/// </summary>
	/// <param name="center">The origo of the circle</param>
	/// <param name="rot">The facing direction of the circle in 3D</param>
	/// <param name="end">If set to <c>true</c> it's the end (bottom) else the start (top).</param>
	/// <param name="dist">The distance from the start of the rope. </param>
	private void createEdge(Vector3 center, Quaternion rot, bool end, float dist)
	{
		int centerIndex = 0;
		if (!end)
		{
			centerIndex = vertices.Count;
			vertices.Add (center);
			uvs.Add(new Vector2(0.5f, 0.5f));
		}
		int circleIndex = vertices.Count;
		createCircle(center, rot, dist);
		if (end) //Top
		{
			centerIndex = vertices.Count;
			vertices.Add (center);
			uvs.Add(new Vector2(0.5f, 0.5f));
			if (rebuild)
			{
				createTriangles(circleIndex-edges, circleIndex);
				for (int i=0; i<edges; i++)
				{
					triangles.Add(centerIndex);
					triangles.Add(circleIndex + i);
					triangles.Add(circleIndex + (i+1)%edges);
				}
			}
		} 
		else //Bottom
		{
			if (rebuild)
			{
				//To make sure backside culling, these need to be in the opposite order.
				for (int i=0; i<edges; i++)
				{
					triangles.Add(circleIndex + (i+1)%edges);
					triangles.Add(circleIndex + i);
					triangles.Add(centerIndex);
				}
			}
		}


	}

	/// <summary>
	/// Creates triangles between two circles, into a cylinder. Doesn't add the top or bottom.
	/// </summary>
	/// <param name="start1">The first virtice of circle 1</param>
	/// <param name="start2">The first virtice of circle 2</param>
	private void createTriangles(int start1, int start2)
	{
		for (int i=0; i<edges; i++)
		{
			triangles.Add(start2 + (i+1)%edges);
			triangles.Add(start2 + i);
			triangles.Add(start1 + i);
			
			triangles.Add(start1 + (i+1)%edges);
			triangles.Add(start2 + (i+1)%edges);
			triangles.Add(start1 + i);
		}
	}

	/// <summary>
	/// Creates a circle of vertices with center as origo and facing the rot quaterion.
	/// </summary>
	/// <param name="center">The origo.</param>
	/// <param name="rot">The facing direction.</param>
	/// <param name="dist">Used to set the uv, the distance so far of the rope.</param>
	private void createCircle(Vector3 center, Quaternion rot, float dist)
	{
		totalDist += dist;
		for (int i=0; i<edges; i++)
		{
			Quaternion circleRot = Quaternion.Euler(new Vector3(0, 0, (360*i)/edges));
			Vector3 newPoint = center + rot* circleRot * (Vector3.up*radius);
			vertices.Add(newPoint);
			uvs.Add(new Vector2(1.0f*i/(edges-1), totalDist));

		}
	}

}
