use image::{
    ImageBuffer,
    Luma
};
fn main() {
    let xorshift = XorShift::new(386765344, 934424);
    let mut tilemap = [State::White; 64 * 64];
    let mut image = ImageBuffer::new(64, 64);

    for (time, seed) in xorshift.enumerate() {
        if time < 4096 {
            let seed = seed % 100;
            tilemap[time] = match seed > 60 {
                true => State::White,
                false => State::Black,
            }
        } else {
            break;
        }
    }

    for i in 0..16 {
        for (x, y, pixel) in image.enumerate_pixels_mut() {
            *pixel = match tilemap[(y * 64 + x) as usize] {
                State::Black => Luma([0_u8]),
                State::White => Luma([255_u8])
            }
        }
        let filename = format!("{}.png", i);
        image.save(filename).unwrap();

        let mut countmap = [0_u8; 66 * 66];

        for (index, tile) in tilemap.iter().enumerate() {
            match tile {
                State::Black => {
                    continue;
                },
                State::White => {
                    let index = index + 67 + (index / 64) * 2;
                    countmap[index - 67] += 1;
                    countmap[index - 66] += 1;
                    countmap[index - 65] += 1;
                    countmap[index + 1] += 1;
                    countmap[index + 67] += 1;
                    countmap[index + 66] += 1;
                    countmap[index + 65] += 1;
                    countmap[index - 1] += 1;
                }
            }
        }

        for (index, count) in countmap.iter().enumerate() {
            if index % 66 != 0 && 
               index % 66 != 65 && 
               index > 66 && 
               index < 4289
            {
                let inner = index - 65 - (index / 66) * 2;
                if countmap[index] > 3 {
                    tilemap[inner] = State::White;
                } else {
                    tilemap[inner] = State::Black;
                }
            }
        }
    }
}

#[derive(Debug, Clone, Copy)]
enum State {
    Black,
    White
}

#[derive(Debug)]
struct XorShift(u32, u32);

impl XorShift {
    fn new(x: u32, y: u32) -> Self {
        Self(x, y)
    }
}

impl Iterator for XorShift {
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> {
        let mut x = self.0;
        let mut y = self.1;
        self.0 = y;
        x ^= x.overflowing_shl(23).0;
        self.1 = x ^ y ^ x.overflowing_shr(17).0 ^ y.overflowing_shr(26).0;

        Some(self.1.overflowing_add(y).0)
    }
}