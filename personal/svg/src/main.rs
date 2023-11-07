fn main() {
    println!("Hello, world!");
}

enum Color {
    Rgba(u8, u8, u8, u8),
    Luma(u8, u8, u8, u8)
}

struct Stroke {
    dash: Option<Vec<usize>>,
    width: Option<usize>,
    opacity: Option<f32>,
    color: Option<Color>
}

struct Style {
    stroke: Option<Stroke>,
    fill: Option<Color>
}

enum SVGComp {
    Line{
        x1: usize,
        y1: usize,
        x2: usize,
        y2: usize,
        style: Option<Style>
    },
    Polygon{
        vertex: Vec<(usize, usize)>,
        style: Option<Style>
    }
}

struct SVGImage {
    comps: Vec<SVGComp>,
    width: usize,
    height: usize
}

impl Stroke {
    fn into(&self) -> str {
        
    }
}