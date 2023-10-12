# Importa a biblioteca 'mysql2' para permitir a conexão com o MySQL.
require 'mysql2'

# Define a classe 'MySQLConnector' que representa um conector para o MySQL.
class MySQLConnector
  # Método de inicialização da classe 'MySQLConnector'.
  # Este método é chamado quando uma nova instância da classe é criada.
  def initialize(host, username, password, database)
    # Cria uma instância da classe 'Mysql2::Client' para estabelecer a conexão com o banco de dados MySQL.
    @client = Mysql2::Client.new(
      host: host,         # Host do banco de dados.
      username: username, # Nome de usuário para autenticação.
      password: password, # Senha para autenticação.
      database: database  # Nome do banco de dados a ser usado.
    )
  end

  # Método 'execute' para executar consultas SQL no banco de dados.
  def execute(sql)
    # Chama o método 'query' na instância do cliente MySQL para executar a consulta SQL.
    @client.query(sql)
  end

  # Método 'close' para fechar a conexão com o banco de dados.
  def close
    # Chama o método 'close' na instância do cliente MySQL para encerrar a conexão.
    @client.close
  end
end