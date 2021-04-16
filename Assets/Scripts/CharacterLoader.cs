using System;
using System.Collections;
using UnityEngine;
using UnityEngine.AddressableAssets;
using UnityEngine.ResourceManagement.AsyncOperations;

public class CharacterLoader : MonoBehaviour
{
    private GameObject characterPrefab;
    public AssetReference characterReference;

    void Update()
    {
        if(Input.GetKeyDown(KeyCode.E))
        {
            CreateCharacter();
        }

        if (Input.GetKeyDown(KeyCode.R))
        {
            StartCoroutine(LoadCharacterFromRef());
        }

        if(Input.GetKeyDown(KeyCode.T))
        {
            InstantiateCharacterFromRef();
        }
    }

    private void InstantiateCharacterFromRef()
    {
        characterReference.InstantiateAsync(Vector3.zero, Quaternion.identity);
    }

    private IEnumerator LoadCharacterFromRef()
    {
        var async = characterReference.LoadAssetAsync<GameObject>();

        while (!async.IsDone)
            yield return new WaitForEndOfFrame();

        characterPrefab = async.Result;
    }

    private void CreateCharacter()
    {
        Addressables.LoadAssetAsync<GameObject>("Characters/PBRCharacter").Completed += OnLoadDone;
    }

    private void OnLoadDone(AsyncOperationHandle<GameObject> task)
    {
        characterPrefab = task.Result;
        Instantiate(characterPrefab);
    }
}
