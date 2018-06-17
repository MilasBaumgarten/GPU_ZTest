using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovePlayer : MonoBehaviour {

	Vector3 currentPos;

	// Use this for initialization
	void Start () {
		currentPos = transform.position;
	}
	
	// Update is called once per frame
	void Update () {
		transform.position = currentPos + Vector3.up * Mathf.Sin(Time.time) * 0.5f; ;
	}
}
