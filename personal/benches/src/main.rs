use bencher::{Bencher, benchmark_group, benchmark_main};

#[derive(Debug, Clone)]
struct Matrix {
    data: Vec<f64>,
    width : usize,
    height: usize
}

impl Matrix {

    // Not initialized
    fn new(width: usize, height: usize) -> Self {
        Self {
            data: vec![0.0; width * height],
            width,
            height
        }
    }

    fn naive_mul(lhs: Self, rhs: Self) -> Self {
        assert_eq!(lhs.width, rhs.height);

        let mut result = Self::new(lhs.height, rhs.width);
        for i in 0..lhs.height {
            for j in 0..rhs.width {
                let mut sum = 0.0;
                for k in 0..lhs.width {
                    sum += lhs.data[i * lhs.width + k] * rhs.data[k * rhs.width + j];
                }
                result.data[i * rhs.width + j] = sum;
            }
        }
        result
    }

    fn fast_mul(lhs: Self, rhs: Self) -> Self {
        let mut result = Self::new(lhs.height, rhs.width);
        for k in 0..lhs.height {
            for i in 0..rhs.height {
                for j in 0..rhs.width {
                    result.data[lhs.width * k + j] += lhs.data[lhs.width * k + i] * rhs.data[lhs.width * i + j];
                }
            }
        }
        result
    }
}

fn naivemul(b: &mut Bencher) {
    let lhs = Matrix{
        data : vec![2.0; 4096],
        width: 64,
        height: 64
    };
    let rhs = Matrix{
        data : vec![0.5; 4096],
        width: 64,
        height: 64
    };

    b.iter(|| {
        for _ in 0..100 {
            let (lhs, rhs) = (lhs.clone(), rhs.clone());

            Matrix::naive_mul(lhs, rhs);
        }
    })
}

fn fastmul(b: &mut Bencher) {
    let lhs = Matrix{
        data : vec![2.0; 4096],
        width: 64,
        height: 64
    };
    let rhs = Matrix{
        data : vec![0.5; 4096],
        width: 64,
        height: 64
    };

    b.iter(|| {
        for _ in 0..100 {
            let (lhs, rhs) = (lhs.clone(), rhs.clone());

            Matrix::fast_mul(lhs, rhs);
        }
    })
}

fn donotwarn(b: &mut Bencher) {}

benchmark_group!(benches, naivemul, fastmul);
benchmark_main!(benches);

