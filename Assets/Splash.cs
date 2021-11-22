using UnityEngine;

public class Splash : ParticleDemo
{
    public ParticleSystem myParticle2;
    
    public override void PlayParticle()
    {
        base.PlayParticle();
        if (!myParticle2.isPlaying) myParticle2.Play();
        Debug.Log("splash particle start particle");
    }
    public override void StopParticle()
    {
        base.PlayParticle();
        myParticle2.Stop();
        Debug.Log("splash particle stop particle");
    }

    /// <summary>
    /// reset to the initial position and state
    /// </summary>
    public override void ResetParticle()
    {
        Debug.Log("reset particle called");
    }
}