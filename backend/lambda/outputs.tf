output "functions" {
  value = zipmap(
    keys(local.function_configs),
    [for function in keys(local.function_configs) : module.lambda_function[function].lambda_function_arn]
  )
}
