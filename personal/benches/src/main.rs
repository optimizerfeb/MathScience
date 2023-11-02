use bencher::{Bencher, benchmark_group, benchmark_main};
use core::f32::consts::E;

const mult32:f32 = 12102203.161561485;
const adder32:f32 = 1064872507.1615615;

const mult64:f64 = 6497320848556798.0;
const adder64:f64 = 4606924340207518000.0;

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
        for _ in 0..1000000 {
            y += x.exp();
        }

        x += 0.00005;
    });
}

fn fast_exp32(bench: &mut Bencher) {
    let mut x: f32 = 1.0;
    let mut y = 0.0;

    bench.iter(|| {
        for _ in 0..1000000 {
            unsafe {
                let mut u = U32 { i: ( x * mult32 + adder32 ) as i32};
            }

            x += 0.00005;
        }
    });
}

fn trad_exp64(bench: &mut Bencher) {
    let mut x: f64 = 1.0;
    let mut y = 0.0;

    bench.iter(|| {
        for _ in 0..1000000 {
            y += x.exp();
        }

        x += 0.0001;
    });
}

fn fast_exp64(bench: &mut Bencher) {
    let mut x: f64 = 1.0;
    let mut y = 0.0;

    bench.iter(|| {
        for _ in 0..1000000 {
            unsafe {
                let mut u = U64 { i: (x * mult64 + adder64) as i64};
            }

            x += 0.0001;
        }
    });
}

benchmark_group!(benches, trad_exp32, fast_exp32, trad_exp64, fast_exp64);
benchmark_main!(benches);

