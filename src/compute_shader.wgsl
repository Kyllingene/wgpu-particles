struct Particle {
  pos: vec2<f32>,
  vel: vec2<f32>,
  col: vec3<f32>,
};

struct SimParams {
  deltaT: f32,
};

@group(0) @binding(0) var<uniform> params: SimParams;
@group(0) @binding(1) var<storage, read> particlesSrc: array<Particle>;
@group(0) @binding(2) var<storage, read_write> particlesDst: array<Particle>;

@compute @workgroup_size(64)
fn main(@builtin(global_invocation_id) global_invocation_id: vec3<u32>) {
    let total = arrayLength(&particlesSrc);
    let index = global_invocation_id.x;
    if (index >= total) {
        return;
    }

    var vPos: vec2<f32> = particlesSrc[index].pos;
    var vVel: vec2<f32> = particlesSrc[index].vel;
    let vCol: vec3<f32> = particlesSrc[index].col;

    vPos += vVel * params.deltaT;

    if (vPos.x < -1.0) {
        vPos.x = 1.0;
    }
    if (vPos.x > 1.0) {
        vPos.x = -1.0;
    }
    if (vPos.y < -1.0) {
        vPos.y = 1.0;
    }
    if (vPos.y > 1.0) {
        vPos.y = -1.0;
    }

    particlesDst[index] = Particle(vPos, vVel, vCol);
}
