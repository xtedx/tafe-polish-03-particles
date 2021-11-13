using UnityEngine;

public abstract class ParticleDemo : MonoBehaviour
{
    public abstract void PlayParticle();
    public abstract void StopParticle();
    /// <summary>
    /// reset to the initial position and state
    /// </summary>
    public abstract void ResetParticle();
}