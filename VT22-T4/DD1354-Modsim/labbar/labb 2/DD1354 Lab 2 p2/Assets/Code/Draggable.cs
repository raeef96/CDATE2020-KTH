using UnityEngine;
using System.Collections;

public class Draggable : MonoBehaviour 
{
    private Transform m_dragHook;

    public Transform GetDragHook()
    {
        return m_dragHook ?? this.transform;
    }

    /*
     * Call this object to change which gameobject is used as hook when dragging.
     */
    public void setDragHook(Transform dragHook)
    {
        //Debug.Log("setting drag hook");
        m_dragHook = dragHook;
    }
    
}
