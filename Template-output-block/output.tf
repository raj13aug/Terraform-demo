output "mad_libs" {
  value = templatefile("forest.txt",
    {
      animals = random_shuffle.random_animals.result
      common  = random_shuffle.random_common.result
  })
}