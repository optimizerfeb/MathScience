use bencher::{Bencher, benchmark_group, benchmark_main};
use core::f32::consts::E;

const lne32: f32 = 1.44269504089;
const mult32:f32 = 8388608.0;
const adder32: f32 = 126.9427;

const lne64: f64 = 1.44269504089;
const mult64:f64 = 4503599627370496.0;
const adder64: f64 = 1022.9427;

union U32 {
    f: f32,
    i: i32,
}

union U64 {
    f: f64,
    i: i64,
}

fn trad_exp32(bench: &mut Bencher) {
    let mut x: f32 = 1.0;
    let mut y = 0.0;

    bench.iter(|| {
        for _ in 0..100000 {
            y += x.exp();
        }

        x += 0.0005;
    });
}

fn fast_exp32(bench: &mut Bencher) {
    let mut x = 1.0;
    let mut y = 0.0;

    bench.iter(|| {
        for _ in 0..100000 {
            unsafe {
                let mut u = U32 { f: x };

                u.i = ((u.f * lne32 + adder32) * mult32) as i32;

                y += u.f;
            }

            x += 0.0005;
        }
    });
}

fn trad_exp64(bench: &mut Bencher) {
    let mut x: f64 = 1.0;
    let mut y = 0.0;

    bench.iter(|| {
        for _ in 0..100000 {
            y += x.exp();
        }

        x += 0.001;
    });
}

fn fast_exp64(bench: &mut Bencher) {
    let mut x: f64 = 1.0;
    let mut y = 0.0;

    bench.iter(|| {
        for _ in 0..100000 {
            unsafe {
                let mut u = U64 { f: x };

                u.i = ((u.f * lne64 + adder64) * mult64) as i64;

                y += u.f;
            }

            x += 0.001;
        }
    });
}

benchmark_group!(benches, trad_exp32, fast_exp32, trad_exp64, fast_exp64);
benchmark_main!(benches);

