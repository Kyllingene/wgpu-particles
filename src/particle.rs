#[repr(C)]
#[derive(Copy, Clone, Debug, Default, PartialEq, bytemuck::Pod, bytemuck::Zeroable)]
pub struct Particle {
    pub position: [f32; 2],
    pub velocity: [f32; 2],
    pub color: [f32; 3],
}

pub const PARTICLE_SIZE: usize = std::mem::size_of::<Particle>();
pub const NUM_PARTICLES: u32 = 64;

pub const PARTICLE_BUFFER_SIZE: u64 = PARTICLE_SIZE as u64 * NUM_PARTICLES as u64;
pub const PARTICLES_PER_GROUP: u32 = 64;

impl Particle {
    const ATTRIBS: [wgpu::VertexAttribute; 3] =
        wgpu::vertex_attr_array![0 => Float32x2, 1 => Float32x2, 2 => Float32x3];

    pub fn desc() -> wgpu::VertexBufferLayout<'static> {
        wgpu::VertexBufferLayout {
            array_stride: PARTICLE_SIZE as wgpu::BufferAddress,
            step_mode: wgpu::VertexStepMode::Instance,
            attributes: &Self::ATTRIBS,
        }
    }
}
