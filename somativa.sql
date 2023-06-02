create database formativaHogwarts;
use formativaHogwarts;

alter table usuarios
add column imagem varchar(100),
add column cell varchar(15);

show tables;
describe usuarios;

create table tarefas(
	id bigint not null auto_increment,
    nome_tarefa varchar(50) not null,
    descricao varchar(300) not null,
    data_inicio datetime not null,
    data_prazo datetime not null,
	data_fim datetime not null,
    solicitacaoFK bigint not null,
	localFK bigint not null,
    fotoFK bigint not null,
    progressoFK bigint not null,
    responsaveisFK bigint not null,
    primary key(id),
	foreign key(solicitacaoFK) references usuario(id),
	foreign key(localFK) references local(id),
    foreign key(fotoFK) references foto_tarefa(id),
    foreign key(progressoFK) references progresso(id),
    foreign key(responsaveisFK) references responsaveis(id)
);

insert into tarefas(nome_tarefa, descricao, data_inicio, data_prazo, data_fim, solicitacao, localFK, fotoFK, progressoFK, responsaveisFK) values
('cabo de internet', 'o cabo esta rompido e precisa ser trocado', '14-05-2023', '20-05-2023', '30-05-2023', 1, 1, 2, 2),
('limpar mesa da sala', 'a mesa da sala esta suja de guarana', '17-06-2023', '20-06-2023', '30-06-2023', 3, 2, 1, 5);

create table responsaveis(
	id bigint not null auto_increment,
    responsaveisFK bigint not null,
    tarefaFK bigint not null,
    primary key(id),
    foreign key(responsaveisFK) references usuario(id),
    foreign key(tarefaFK) references tarefas(id) 
);

create table progresso(
	id bigint not null auto_increment,
    status enum('aberta', 'Em andamento', 'Concluida', 'Encerrada'),
	dataAndamento datetime not null auto_increment,
    dataConclusao datetime not null auto_increment,
    comentarios varchar(300) not null,
    primary key(id)
);


create table status(
	id bigint not null auto_increment,
    feita enum("sim", "não") not null,
    data_mod datetime not null,
    progressoFK bigint not null,
    primary key (id),
    foreign key(progresso) references progresso(id)
);



create table foto_tarefa(
	id bigint not null auto_increment,
    link_foto varchar(100),
    primary key(id)
);



select * from locais;
select * from usuarios;


