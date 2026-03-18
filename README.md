[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/OwTRjgv_)
## Project 00
### NeXTCS
### Period: 9
## Thinker0: Aarushi Jain
## Thinker1: Aabdullah Jaami
## Thinker2: Nelson Liu
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: Electrostatic force

### Custom Force Formula
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

$$ {\overrightarrow F} = k \dfrac{q1q2}{r^2} $$

### Custom Force Breakdown
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - r will be the distance between the two orbs. 

- Does this force require any new constants, if so what are they and what values will you try initially?
  - k; which is coulomb's constant. We're going to use 8.99 * 10^9 for ours.

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - The amount of charge each particle has. Use int for this

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - Yes, based on the charges. The orbs will each be assigned a charge, and the electorstatic force will be calculated and executed based on those charges. 

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - 

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

Use Newton's gravitational force law to determine the gravity between two objects and also add velocity to both objects so they don't collide into each other

--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

We will create springs between the objects we are using. When the objects move around, the spring can be compressed or expanded depending on the movement. 

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

Our drag simulation will be a object moving through a fluid and there will be drag force opposing its motion.

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

The objects will either repel or attract each other depending on their charges (like charges repel; unlike charges attract)

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

Our combination simulation will integrate all parts of the prior simulations. 
We can use springs between the objects that will contract and expand depending on the electrostatic force (when the obejcts repel the spring will expand; when the objects attract the spring will contract). Gravity and drag can be applied on the objects as well. 
