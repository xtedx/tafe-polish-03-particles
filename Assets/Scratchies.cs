using UnityEngine;

public class Scratchies : ParticleDemo
{    
    public Rigidbody body;
    public float force = 2;
    
    /// <summary>
    /// height to keep the rocket in screen view
    /// </summary>
    public float maxHeight = 6;
    // Start is called before the first frame update
    private void Start()
    {
        body = GetComponent<Rigidbody>();
        PlayParticle();
    }

    // Update is called once per frame
    private void Update()
    {

    }

    public override void ToggleParticle()
    {
        Debug.Log($"particle is playing {myParticle.isPlaying}");
        if (myParticle.isPlaying)
            StopParticle();
        else
            PlayParticle();
    }

    public override void ToogleParticle(bool play)
    {
        if (play)
            PlayParticle();
        else
            StopParticle();
    }

    public override void PlayParticle()
    {
        if (!myParticle.isPlaying) myParticle.Play();
    }

    public override void StopParticle()
    {
        myParticle.Stop();
    }

    public override void ResetParticle()
    {
        Debug.Log("reset particle called");
    }
}