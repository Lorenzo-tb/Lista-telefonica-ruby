# Importa o arquivo './models/db.rb', que contém a classe MySQLConnector, para permitir a conexão com o MySQL.
require_relative './models/db'

# Importa a biblioteca 'dotenv' para carregar as variáveis de ambiente do arquivo .env.
require 'dotenv'

# Carrega as variáveis de ambiente do arquivo .env.
Dotenv.load

# Define variáveis para armazenar as informações de conexão ao banco de dados MySQL, obtidas do arquivo .env.
host = ENV['HOST']
usuario = ENV['USUARIO'] #caso coloque 'USERNAME' ou 'USER' ele puxará o nome de usuário do sistema operacional
senha = ENV['PASSWORD']
banco = ENV['DATABASE']

# Cria uma instância da classe MySQLConnector, passando as informações de conexão como argumentos.
db = MySQLConnector.new(host, usuario, senha, banco)

# Inicia um loop que permite que o usuário escolha várias ações para interagir com a lista telefônica.
loop do
    # Exibe um menu de opções para o usuário.
    puts "Lista Telefônica\nDigite: \n1. Adicionar Telefone \n2. Editar Telefone \n3. Excluir telefone \n4. Visualizar Telefones \n0. Sair \n"
    
    # Lê a entrada do usuário e a converte para um número inteiro.
    codigo = gets.chomp.to_i

    # Usa uma estrutura de controle 'case' para executar a ação correspondente com base no código inserido pelo usuário.
    case codigo
    when 0
        # Exibe uma mensagem de despedida e fecha a conexão com o banco de dados.
        puts "Obrigado por usar meu programa :)!"
        db.close
        break

    when 1
        # Solicita ao usuário que insira o nome e o telefone da pessoa a ser adicionada à lista.
        puts "Insira o nome da pessoa: \n"
        nome = gets.chomp
        puts "Insira o telefone da pessoa: \n"
        telefone = gets.chomp
    
        # Constrói uma consulta SQL para inserir o novo registro na tabela 'telefones'.
        query = "INSERT INTO telefones(nome, telefone) VALUES('#{nome}', '#{telefone}');"
        
        # Executa a consulta SQL usando a instância do MySQLConnector.
        db.execute(query)

    when 2
        # Solicita ao usuário o nome da pessoa cujo telefone será editado e o novo número de telefone.
        puts "Insira o nome da pessoa que você quer editar o telefone: "
        nome = gets.chomp
        puts "Insira o novo telefone: "
        telefone = gets.chomp
        
        # Constrói uma consulta SQL para atualizar o número de telefone no registro correspondente.
        query = "UPDATE telefones SET telefone = '#{telefone}' WHERE nome = '#{nome}'"
        
        # Executa a consulta SQL usando a instância do MySQLConnector.
        db.execute(query)

    when 3
        # Solicita ao usuário o nome da pessoa a ser excluída da lista.
        puts "Insira o nome da pessoa que você quer excluir da lista: "
        nome = gets.chomp
    
        # Constrói uma consulta SQL para excluir o registro com base no nome da pessoa.
        query = "DELETE FROM telefones WHERE nome = '#{nome}'"
        
        # Executa a consulta SQL usando a instância do MySQLConnector.
        db.execute(query)

    when 4
        # Constrói uma consulta SQL para selecionar e exibir todos os registros da tabela 'telefones'.
        query = 'SELECT * FROM telefones'
    
        # Executa a consulta SQL e itera sobre os resultados para exibir os nomes e telefones.
        resp = db.execute(query)
        resp.each do |item|
            puts "Nome: #{item['nome']}, Telefone: #{item['telefone']}"
        end
        puts "\n"

    else
        # Exibe uma mensagem de erro se o usuário inserir um código inválido.
        puts "Valor inválido"
    end
end