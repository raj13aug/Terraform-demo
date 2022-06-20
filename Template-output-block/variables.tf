variable "words" {
  description = "A word pool to use for Mad Libs"
  type = object({
    animals = list(string),
    common  = list(string),
  })
}