using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

public class EulerIntegrator : Integrator
{
    public void Advance(List<RopePoint> points, Action<float> updateForcesFunc, float timeStep)
    {
        updateForcesFunc(timeStep);

        foreach (var point in points)
        {
            point.State.Velocity += (timeStep / point.Mass) * point.Force;
            point.State.Position += timeStep * point.State.Velocity;
        }
    }
}
