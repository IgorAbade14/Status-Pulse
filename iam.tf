# 1. Cria o usuário para o GitHub
resource "aws_iam_user" "github_actions" {
  name = "github-actions-user"
}

# 2. Dá permissão de Administrador para ele (para ele poder criar as coisas)
resource "aws_iam_user_policy_attachment" "admin_access" {
  user       = aws_iam_user.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# 3. Gera as chaves que você tanto precisa!
resource "aws_iam_access_key" "github_keys" {
  user = aws_iam_user.github_actions.name
}

# 4. Faz o Terraform mostrar as chaves no terminal para você copiar
output "github_access_key_id" {
  value = aws_iam_access_key.github_keys.id
}

output "github_secret_access_key" {
  value     = aws_iam_access_key.github_keys.secret
  sensitive = true
}