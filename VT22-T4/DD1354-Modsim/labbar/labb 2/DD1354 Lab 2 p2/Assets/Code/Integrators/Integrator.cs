﻿using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

public enum IntegratorType
{ 
    Euler,
    Leapfrog,
    RK4
}

public interface Integrator
{
    void Advance(List<RopePoint> points, Action<float> updateForcesFunc, float timeStep);
}
