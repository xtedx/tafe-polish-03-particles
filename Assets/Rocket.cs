using UnityEngine;

public class Rocket : ParticleDemo
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
        if (myParticle.isPlaying)
        {
            Propel();
        }
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

    public void Propel()
    {
        if (transform.position.y < maxHeight)
        {
            body.AddForce(Vector3.up * force);
        }
    }

    public override void ResetParticle()
    {
        Debug.Log("reset particle called");

        myParticle.Stop();
        body.isKinematic = true;
        var rot = new Quaternion(0,0,0,0);
        var pos = new Vector3(0, 3f, 0);
        myPlayer.transform.SetPositionAndRotation(Vector3.zero, rot);
        transform.SetPositionAndRotation(pos, rot);
        body.isKinematic = false;
    }
}