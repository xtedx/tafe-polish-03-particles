using System;
using TeddyToolKit.Core;
using UnityEngine;
using UnityEngine.UI;

public class Main : MonoSingleton<Main>
{
    public GameObject currentDemo;
    public Text TextCurrentDemo;
    public ParticleDemo currentParticle;
    public GameObject[] demos;
    
    // Start is called before the first frame update
    private void Start()
    {
        ButtonSetDemo(demos[1]);
    }

    // Update is called once per frame
    private void Update()
    {
    }

    public void ButtonPlayDemo()
    {
        GetParticle();
        PlayParticle();
    }

    public void ButtonStopDemo()
    {
        GetParticle();
        StopParticle();
    }

    /// <summary>
    /// get the current demo's particle
    /// </summary>
    private void GetParticle()
    {
        currentParticle = currentDemo.GetComponentInChildren<ParticleDemo>();
    }

    private void PlayParticle()
    {
        currentParticle.PlayParticle();
    }

    private void StopParticle()
    {
        currentParticle.StopParticle();
    }

    /// <summary>
    /// set the current active demo
    /// </summary>
    /// <param name="demoGameObject"></param>
    public void ButtonSetDemo(GameObject demoGameObject)
    {
        currentDemo = demoGameObject;
        TextCurrentDemo.text = currentDemo.name;
        foreach (var o in demos)
        {
            o.SetActive(o.name == currentDemo.name);
            try
            {
                o.GetComponentInChildren<ParticleDemo>().ResetParticle();
            }
            catch (NullReferenceException)
            {
                //skip if no particle
                continue;
            }
            Debug.Log("set demo called");
        }

    }
}