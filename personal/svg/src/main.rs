use image::{
    ImageBuffer,
    Rgba
};

fn main() {
    let mut march = March::new(32, 24, 0.5);

    march.fill(0, 0);
    march.fill(11, 0);
    march.fill(24, 8);
    march.fill(24, 11);
    march.fill(31, 23);
    march.fill(30, 22);
    march.fill(16, 12);
    march.fill(8, 22);
    march.fill(12, 16);
    march.fill(13, 13);

    march.march();

    let image = march.render();

    image.save("march.png").unwrap();
}

struct March {
    trace: Vec<(f32, f32)>,
    current: (f32, f32),
    direction: (f32, f32),
    width: usize,
    height: usize,
    map: Vec<bool>
}

impl March {
    fn new(width: usize, height: usize, angle: f32) -> March {
        March {
            trace: vec![(4.0, 4.0)],
            current: (4.0, 4.0),
            direction: (angle.cos(), angle.sin()),
            width,
            height,
            map: vec![false; width * height]
        }
    }

    fn sdf(&self, (x, y): (f32, f32)) -> f32 {
        let mut result = f32::MAX;

        for i in 0..self.width {
            for j in 0..self.height {
                if self.map[i + j * self.width] == false {
                    continue;
                }

                let (i, j) = (i as f32, j as f32);
                let mut distance:f32 = 0.0;

                if x < i {
                    if y < j {
                        distance = ((i - x).powi(2) + (j - y).powi(2)).sqrt();
                    } else if y > j + 1.0 {
                        distance = ((i - x).powi(2) + (y - j - 1.0).powi(2)).sqrt();
                    } else {
                        distance = i - x;
                    
                    }
                } else if x > i + 1.0 {
                    if y < j {
                        distance = ((x - i - 1.0).powi(2) + (j - y).powi(2)).sqrt();
                    } else if y > j + 1.0 {
                        distance = ((x - i - 1.0).powi(2) + (y - j - 1.0).powi(2)).sqrt();
                    } else {
                        distance = x - i - 1.0;
                    }
                } else {
                    if y < j {
                        distance = j - y;
                    } else if y > j + 1.0 {
                        distance = y - j - 1.0;
                    } else {
                        distance = y - j;
                        distance.min(x - i);
                        distance.min(i - x + 1.0);
                        distance.min(j - y + 1.0);

                        distance = -distance;
                    }
                }

                result = result.min(distance);
            }
        }

        result
    }

    fn fill(&mut self, x: usize, y: usize) {
        self.map[x + y * self.width] = true;
    }

    fn march(&mut self) {
        self.trace.push(self.current);

        let epsilon = 0.1;
        let mut marched = 0.0;

        while self.sdf(self.current) > epsilon && marched < 56.0 {
            let (x, y) = self.current;
            let (dx, dy) = self.direction;
            let distance = self.sdf(self.current);

            self.current = (x + (dx * distance), y + (dy * distance));

            marched += distance;
            self.trace.push(self.current);

            println!("{:?}, {}", self.current, marched);
        }
    }

    fn render(&self) -> ImageBuffer<Rgba<u8>, Vec<u8>> {
        let mut image = ImageBuffer::new((self.width * 16) as u32, (self.height * 16) as u32);
        
        for (x, y, pixel) in image.enumerate_pixels_mut() {
            let (gx, gy) = ((x / 16) as usize, (y / 16) as usize);

            if self.map[gx + gy * self.width] {
                *pixel = Rgba([0, 0, 0, 255]);
            } else {
                *pixel = Rgba([255, 255, 255, 255]);
            }

            let (fx, fy) = (x as f32, y as f32);
            let (a, b) = self.direction;

            if (a * (fx - 32.0) - b * (fy - 32.0)).abs() < 1.0 {
                *pixel = Rgba([0, 0, 255, 255]);
            }

            for (index, (px, py)) in self.trace.iter().enumerate() {
                let (px, py) = (px * 16.0, py * 16.0);
                let dist = self.sdf(self.trace[index]);

                let pixdist = ((fx - px).powi(2) + (fy - py).powi(2)).sqrt() / 16.0;

                if pixdist < 3.0 / 16.0 {
                    *pixel = Rgba([255, 0, 0, 255]);
                } else if (pixdist - dist).abs() < 1.0 / 16.0 {
                    *pixel = Rgba([0, 255, 0, 255]);
                }
            }
        }

        image
    }
}