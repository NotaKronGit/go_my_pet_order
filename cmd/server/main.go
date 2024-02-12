package main

func main() {
	println("order service")

	if err := run(); err != nil {
		println("failed")
	}
}

func run() error {
	println("startup")

	return nil
}
