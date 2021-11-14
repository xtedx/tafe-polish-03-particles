using UnityEngine;

public abstract class ParticleDemo : MonoBehaviour
{
    public ParticleSystem myParticle;
    public GameObject myPlayer;

    public virtual void PlayParticle()
    {
        if (!myParticle.isPlaying) myParticle.Play();
    }
    public virtual void StopParticle()
    {
        myParticle.Stop();
    }

    /// <summary>
    /// reset to the initial position and state
    /// </summary>
    public virtual void ResetParticle()
    {
        Debug.Log("reset particle called");
    }

    public virtual void ToggleParticle()
    {
        Debug.Log($"particle is playing {myParticle.isPlaying}");
        if (myParticle.isPlaying)
            StopParticle();
        else
            PlayParticle();
    }

    public virtual void ToogleParticle(bool play)
    {
        if (play)
            PlayParticle();
        else
            StopParticle();
    }
}