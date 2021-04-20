using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using Debug = UnityEngine.Debug;

public class Test : MonoBehaviour
{
    [MenuItem("Assets/test")]
    static void test()
    {
        Debug.Log( string.Format("AssetDataPath :{0}",Application.dataPath));
    }
}
