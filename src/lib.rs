use rand;

pub fn test_func2() -> String {
    let x = rand::random::<u16>();
    format!("Your number is {}", x)
}
