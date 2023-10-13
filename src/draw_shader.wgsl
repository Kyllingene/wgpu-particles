struct Particle {
    @location(0) position: vec2<f32>,
    @location(1) velocity: vec2<f32>,
    @location(2) color: vec3<f32>,
};

struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) color: vec3<f32>,
};

@vertex
fn main_vs(
    particle: Particle,
) -> VertexOutput {
    var out: VertexOutput;

    out.position = vec4<f32>(particle.position, 0.0, 1.0);
    out.color = particle.color;

    return out;
}

@fragment
fn main_fs(in: VertexOutput) -> @location(0) vec4<f32> {
    return vec4<f32>(in.color, 1.0);
}
