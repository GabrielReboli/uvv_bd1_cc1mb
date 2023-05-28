-- Apagar, caso exista, o banco de dados com nome uvv
DROP DATABASE IF EXISTS uvv;

-- Apagar, caso exista, o usuário com nome gabriel
DROP USER IF EXISTS gabriel;

-- Criar usuário com permissão de criar bancos de dados e criar outras roles. O usuário possui senha criptografada
CREATE USER gabriel 
  WITH PASSWORD '202cb962ac59075b964b07152d234b70' 
    CREATEDB 
    CREATEROLE;

-- Criar o banco de dados uvv
CREATE DATABASE uvv
  WITH OWNER = gabriel
       TEMPLATE = template0
       ENCODING = 'UTF8'
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       ALLOW_CONNECTIONS = true;
	   
-- Incluir comentário nos metadados para descrever o banco de dados Lojas UVV
COMMENT ON DATABASE uvv IS 'Este é o banco de dados que armazenará e organizará o conteúdo referente as lojas uvv';

-- Conecta o banco de dados com o usuário sem a necessidade de senha
\connect postgresql://gabriel:202cb962ac59075b964b07152d234b70@localhost/uvv

-- Criar o esquema lojas e autorizar o usuário a utilizar o esquema
CREATE SCHEMA lojas 
  AUTHORIZATION gabriel;

-- Alterar o caminho do esquema para que as tabelas sejam criadas no esquema lojas
SET SEARCH_PATH TO lojas, public;

-- Torna a mudança do caminho do esquema permanente
ALTER ROLE gabriel SET SEARCH_PATH TO lojas, public;
	

-- Criar tabela produtos
CREATE TABLE 		lojas.produtos (
					produto_id                  NUMERIC(38) 	  NOT NULL,
					nome                        VARCHAR(255) 	  NOT NULL,
					preco_unitario              NUMERIC(10,2),
					detalhes                    BYTEA,
					imagem                      BYTEA,
					imagem_mime_type            VARCHAR(512),
					imagem_arquivo		    VARCHAR(512),
					imagem_charset              VARCHAR(512),
					imagem_ultima_atualizacao   DATE
               

);

-- Incluir comentário nos metadados para descrever a tabela produtos
COMMENT ON TABLE lojas.produtos IS 'Armazena os produtos disponíveis.';

-- Incluir comentários nos metadados para descrever as colunas da tabela produtos
COMMENT ON COLUMN 	lojas.produtos.produto_id                   IS 'Chave primária da tabela produtos. Identifica o produto.';
COMMENT ON COLUMN 	lojas.produtos.nome                         IS 'Nome do produto.';
COMMENT ON COLUMN 	lojas.produtos.preco_unitario               IS 'Preço unitário do produto.';
COMMENT ON COLUMN 	lojas.produtos.detalhes                     IS 'Detalhes do produto em questão.';
COMMENT ON COLUMN 	lojas.produtos.imagem                       IS 'Imagem do produto em questão.';
COMMENT ON COLUMN 	lojas.produtos.imagem_mime_type             IS 'Formato de imagem da imagem do produto.';
COMMENT ON COLUMN	lojas.produtos.imagem_arquivo		    IS 'Coluna para armazenar o arquivo da imagem';
COMMENT ON COLUMN 	lojas.produtos.imagem_charset               IS 'Conjunto de caracteres da da imagem.';
COMMENT ON COLUMN 	lojas.produtos.imagem_ultima_atualizacao    IS 'Data da última atualização da imagem do produto.';




-- Criar tabela lojas
CREATE TABLE lojas.lojas (
                loja_id                     NUMERIC(38) 	NOT NULL,
                nome                        VARCHAR(255) 	NOT NULL,
                endereco_web                VARCHAR(100),
                endereco_fisico             VARCHAR(512),
                latitude                    NUMERIC,
                longitude                   NUMERIC,
                logo                        BYTEA,
                logo_mime_type              VARCHAR(512),
                logo_arquivo                VARCHAR(512),
                logo_charset                VARCHAR(512),
                logo_ultima_atualizacao     DATE


);

-- Incluir comentário nos metadados para descrever a tabela lojas
COMMENT ON TABLE lojas.lojas                           	IS 'Tabela que armazena as lojas a dispor.';

-- Incluir comentários nos metadados para descrever as colunas da tabela lojas
COMMENT ON COLUMN lojas.lojas.loja_id                   IS 'Chava primária da tebela lojas. Identifica a loja.';
COMMENT ON COLUMN lojas.lojas.nome                      IS 'Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web              IS 'Endereço eletrônico do site referente à loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico           IS 'Endereço completo da loja física.';
COMMENT ON COLUMN lojas.lojas.latitude                  IS 'Latitude da loja. Distancia em graus da loja e a linha do equador.';
COMMENT ON COLUMN lojas.lojas.longitude                 IS 'Longitude da loja. Distância em graus medida entre a loja e o Meridiano de Greenwich.';
COMMENT ON COLUMN lojas.lojas.logo                      IS 'Logotipo que identifica e representa a loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type            IS 'Formato de imagem da logo.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo              IS 'Armazena o nome do arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset              IS 'Conjunto de caracteres da logotipo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao   IS 'Data da última atualização da logotipo.';




-- Criar tabela estoques
CREATE TABLE lojas.estoques (
                estoque_id 		NUMERIC(38) 	NOT NULL,
                loja_id 		NUMERIC(38) 	NOT NULL,
                produto_id 		NUMERIC(38) 	NOT NULL,
                quantidade 		NUMERIC(38) 	NOT NULL
				

);
-- Incluir comentário nos metadados para descrever a tabela estoques
COMMENT ON TABLE lojas.estoques                 IS 'Armazena as informações referentes aos estoques de produtos da lojas.';

-- Incluir comentários nos metadados para descrever as colunas da tabela estoques
COMMENT ON COLUMN lojas.estoques.estoque_id     IS 'Chave primária da tabela estoques. Identifica o estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id        IS 'Chave estrangeira da tebla lojas. Identifica a loja.';
COMMENT ON COLUMN lojas.estoques.produto_id     IS 'Chave estrangeira da tabela produtos. Identifica o produto.';
COMMENT ON COLUMN lojas.estoques.quantidade     IS 'Quantidade do estoque.';




-- Criar tabela clientes
CREATE TABLE lojas.clientes (
                cliente_id    NUMERIC(38) 	  NOT NULL,
                email         VARCHAR(255) 	  NOT NULL,
                nome          VARCHAR(255) 	  NOT NULL,
                telefone1     VARCHAR(20),
                telefone2     VARCHAR(20),
                telefone3     VARCHAR(20)
				

);
-- Incluir comentário nos metadados para descrever a tabela clientes
COMMENT ON TABLE  lojas.clientes                IS 'Tabela de clientes. Contém o id do cliente, email, nome e telefones para contato.';

-- Incluir comentários nos metadados para descrever as colunas da tabela clientes
COMMENT ON COLUMN lojas.clientes.cliente_id     IS 'Chave primária da tabela clientes. Identifica cada cleinte.';
COMMENT ON COLUMN lojas.clientes.email          IS 'Endereço de email do cliente.';
COMMENT ON COLUMN lojas.clientes.nome           IS 'Nome completo do cliente como no RG.';
COMMENT ON COLUMN lojas.clientes.telefone1      IS 'Telefone primário para contato com o cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2      IS 'Telefone secundário para contato com o cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3      IS 'Telefone terciário para contato com o cliente.';




-- Criar tabela envios
CREATE TABLE lojas.envios (
                envio_id            NUMERIC(38) 	  NOT NULL,
                loja_id             NUMERIC(38) 	  NOT NULL,
                cliente_id          NUMERIC(38) 	  NOT NULL,
                endereco_entrega    VARCHAR(512) 	  NOT NULL,
                status              VARCHAR(15) 	  NOT NULL
				
);
-- Incluir comentário nos metadados para descrever a tabela envios
COMMENT ON TABLE  lojas.envios                      IS 'Armazena os envios realizados.';

-- Incluir comentários nos metadados para descrever as colunas da tabela envios
COMMENT ON COLUMN lojas.envios.envio_id             IS 'Chave primária da tebela envios. Identifica o envio.';
COMMENT ON COLUMN lojas.envios.loja_id              IS 'Chave estrangeira da tabela lojas. Identifica a loja.';
COMMENT ON COLUMN lojas.envios.cliente_id           IS 'Chave estrangeira da tabela clientes. Identifica o cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega     IS 'Endereço completo do destino que deverá ser realizada a entrega do pedido.';
COMMENT ON COLUMN lojas.envios.status               IS 'Estado do envio. Identifica as etapas do processo.';




-- Criar tabela pedidos
CREATE TABLE lojas.pedidos (
                pedido_id     NUMERIC(38) 	  	NOT NULL,
                data_hora     TIMESTAMP 		NOT NULL,
                cliente_id    NUMERIC(38) 	  	NOT NULL,
                status        VARCHAR(15) 	  	NOT NULL,
                loja_id       NUMERIC(38) 	  	NOT NULL
				

);
-- Incluir comentário nos metadados para descrever a tabela pedidos
COMMENT ON TABLE  lojas.pedidos             IS 'Tabela com os pedidos realizados.';

-- Incluir comentários nos metadados para descrever as colunas da tabela pedidos
COMMENT ON COLUMN lojas.pedidos.pedido_id   IS 'Chave primária da tabela. Identifica o pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora   IS 'Data e horário da realização do pedido.';
COMMENT ON COLUMN lojas.pedidos.cliente_id  IS 'Chave estrangeira da tabela clientes. Identifica o cliente.';
COMMENT ON COLUMN lojas.pedidos.status      IS 'Estado do pedido.';
COMMENT ON COLUMN lojas.pedidos.loja_id     IS 'Chave estrangeira da tabela lojas. Identifica a loja.';




-- Criar tabela pedidos_itens
CREATE TABLE lojas.pedidos_itens (
                pedido_id           NUMERIC(38) 	  	NOT NULL,
                produto_id          NUMERIC(38) 	  	NOT NULL,
                numero_da_linha     NUMERIC(38) 	  	NOT NULL,
                preco_unitario      NUMERIC(10,2)		NOT NULL,
                quantidade          NUMERIC(38) 	  	NOT NULL,
                envio_id            NUMERIC(38)
                
);

-- Incluir comentário nos metadados para descrever a tabela pedidos_itens
COMMENT ON TABLE  lojas.pedidos_itens                   IS 'Armazena os itens de cada pedido.';

-- Incluir comentários nos metadados para descrever as colunas da tabela pedidos_itens
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id         IS 'Chave primária da tabela pedidos_itens. Chave estrangeira da tabela pedidos. Identifica o pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id        IS 'Chave primária da tabela pedidos_itens. Chave estrangeira da tabela produtos. Identifica o produto.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha   IS 'Número da linha onde se encontra o item no determinado pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario    IS 'Preço unitário do produto.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade        IS 'Quantidade de determinado item no pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id          IS 'Chave estrangeira da tabela envios. Identifica o envio.';




---- Criar as chaves primárias


-- Criar a chave primária da tabela produtos
ALTER TABLE lojas.produtos
ADD CONSTRAINT pk_produtos 
PRIMARY KEY (produto_id);

-- Criar chaves primárias da tabela lojas
ALTER TABLE lojas.lojas
ADD CONSTRAINT pk_lojas 
PRIMARY KEY (loja_id);

-- Criar a chave primária da tabela estoques
ALTER TABLE lojas.estoques
ADD CONSTRAINT pk_estoques 
PRIMARY KEY (estoque_id);

-- Criar a chave primária da tabela clientes
ALTER TABLE lojas.clientes
ADD CONSTRAINT pk_clientes 
PRIMARY KEY (cliente_id);

-- Criar a chave primária da tabela envios
ALTER TABLE lojas.envios
ADD CONSTRAINT pk_envios 
PRIMARY KEY (envio_id);

-- Criar a chave primária da tabela pedidos
ALTER TABLE lojas.pedidos
ADD CONSTRAINT pk_pedidos 
PRIMARY KEY (pedido_id);

-- Criar a chave primária da tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT pk_pedidos_itens 
PRIMARY KEY (pedido_id, produto_id);



---- Criar as restrições de checagem 


-- Criar as restrições de checagem da tabela produtos

-- Criar restrição de checagem que garanta que o preço unitário seja maior que zero
ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_preco_unitario 
CHECK (preco_unitario > 0);

-- Criar restrição de checagem que garanta que o id do produto seja maior que zero
ALTER TABLE lojas.produtos
ADD CONSTRAINT cc_produtos_produto_id 
CHECK (produto_id > 0);



-- Criar as restrições de checagem da tabela lojas

-- Criar restrição de checagem que garanta que o id da loja seja maior que zero
ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_loja_id 
CHECK (loja_id > 0);

-- Criar restrição de checagem que garanta que ambos endereços, fisico e web, não sejam simultaneamente nulos
ALTER TABLE lojas.lojas
ADD CONSTRAINT cc_lojas_endereco 
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);



-- Criar as restrições de checagem da tabela estoques

-- Criar restrição de checagem que garanta que o id do estoque seja maior que zero
ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_estoque_id
CHECK (estoque_id > 0);

-- Criar restrição de checagem que garanta que o id da loja seja maior que zero
ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_loja_id
CHECK (loja_id > 0);

-- Criar restrição de checagem que garanta que o id do produto seja maior que zero
ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_produto_id 
CHECK (produto_id > 0);

-- Criar restrição de checagem que garanta que a quantidade seja maior ou igual a zero
ALTER TABLE lojas.estoques
ADD CONSTRAINT cc_estoques_quantidade 
CHECK (quantidade >= 0);



-- Criar as restrições de checagem da tabela clientes

-- Criar restrição de checagem que garanta que id do cliente seja mior que zero
ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_clientes_cliente_id 
CHECK (cliente_id > 0);

-- Criar restrição de checagem que garanta que os telefones fornecidos não sejam iguais
ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_clientes_telefone 
CHECK (telefone1 <> telefone2 AND telefone1 <> telefone3 AND telefone2 <> telefone3);

-- Criar restrição de checagem que garanta a inserção de um email válido
ALTER TABLE lojas.clientes
ADD CONSTRAINT cc_clientes_email  
CHECK(email LIKE '% @ %');



-- Criar as restrições de checagem da tabela produtos

-- Criar restrição de checagem que define os valores aceitos para o status do envio
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status 
CHECK (status in('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Criar restrição de checagem que garanta que o id do envio seja maior que zero
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_envio_id 
CHECK (envio_id > 0);

-- Criar restrição de checagem que garanta que o id da loja seja maior que zero
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_loja_id 
CHECK (loja_id > 0);

-- Criar restrição de checagem que garanta que o id do cliente seja maior que zero
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_cliente_id 
CHECK (cliente_id > 0);



-- Criar as restrições de checagem da tabela pedidos

-- Criar restrição de checagem que define os valores aceitos para o status do pedido 
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_status 
CHECK (status in('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

-- Criar restrição de checagem que garanta que o id do pedido seja maior que zero
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_pedido_id
CHECK (pedido_id > 0);

-- Criar restrição de checagem que garanta que o id do cliente seja maior que zero
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_cliente_id
CHECK (cliente_id > 0);

-- Criar restrição de checagem que garanta que o id da loja seja maior que zero
ALTER TABLE lojas.pedidos
ADD CONSTRAINT cc_pedidos_loja_id
CHECK (loja_id > 0);



-- Criar as restrições de checagem da tabela pedidos_itens

-- Criar restrição de checagem que garanta que o id do pedido seja maior que zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_pedido_id
CHECK (pedido_id > 0);

-- Criar restrição de checagem que garanta que o id do produto seja maior que zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_produto_id
CHECK (produto_id > 0);

-- Criar restrição de checagem que garanta que o id do envio seja maior que zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_envio_id
CHECK (envio_id > 0);

-- Criar restrição de checagem que garanta que a quantidade de itens do pedido seja maior que zero, uma vez que deve haver pelo menos um item para existir um pedido
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK (quantidade > 0);

-- Criar restrição de checagem que garanta que o preço unitário seja maior que zero
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK (preco_unitario > 0);



----Criar as chaves estrangeiras


-- Criar chave estrangeira produto_id na tabela estoque
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk 
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira produto_id na tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira loja_id na tabela pedidos
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira loja_id na tabela envios
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira loja_id na tabela estoques
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira cliente_id na tabela pedidos
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira cliente_id na tabela envios
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira envio_id na tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criar chave estrangeira pedido_id na tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
