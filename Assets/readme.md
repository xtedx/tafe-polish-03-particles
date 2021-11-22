#ass 3 plan
##requirements todo
- all done

##requirements done
* 5 particles
  * scratchies lotto effect - simulate the animation of scratching those scratchies with a coin, the debris will fall down
  * rocket exhaust - simulate the fire coming out from the bottom of rocket launch
  * smoke particle - simulate the smoke coming out from a chimney
  * water drop splash - simulate the splash of water when an object is dropped into it
  * fireworks - simulate fireworks with second explosions on death of the first in different colours

* 5 shaders
  * sepia/monochrome - adds a filter to a texture and make it sepia toned.
  * transparent - makes an object appear transparent/translucent
  * wireframe - simulate the effect of wireframe object using shaders
  * fresnel - simulate the glowing effect using fresnel effect
  * moving animation - makes an object appear moving, like a travelator/escalator

* water simulator
  * in a separate 2d project

* demo objects

* feedback from others, make at least one change from the feedback

* particle performance test, write down the framerate for particles, and if it needs optimisation. using the profiler, we can see the frame rates
  * the frame rates are very high, meaning that these shaders and particles are very performant.
  * we can see from the screenshot of the profiler:
    * cpu usage of 10000 fps and 0.1ms for all of the particles and shaders shown together on screen
    * gpu usage of mostly 1000 fps and 1 ms
    * global illumination also is in the range of 4000fps and faster
  * looking at these results, there is no need to optimise the effects, because the calculations are relatively simple ones

* unity APP zip
* github link https://github.com/xtedx/tafe-polish-03-particles

##plan
have a button for each particle/shader on the gui
play and stop button at the top

##bugs:
* sometimes reset does not work because somehow rigidbody changes the Y pos to negative when it was 0 at the same positon

##resources:
* https://github.com/jongallant/LiquidSimulator
* http://www.shaderslab.com/shaders.html
* https://assetstore.unity.com/packages/essentials/tutorial-projects/unity-particle-pack-127325
* https://www.dreamstime.com/stock-photo-escalator-texture-floor-straight-line-image54795425
* 