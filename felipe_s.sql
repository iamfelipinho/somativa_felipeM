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


insert into tarefas(nome_tarefa, descricao, data_inicio, data_prazo, data_fim, solicitacao, localFK, fotoFK, progressoFK, responsaveisFK) values
('cabo de internet', 'o cabo esta rompido e precisa ser trocado', '14-05-2023', '20-05-2023', '30-05-2023', 1, 1, 2, 2),
('limpar mesa da sala', 'a mesa da sala esta suja de guarana', '17-06-2023', '20-06-2023', '30-06-2023', 3, 2, 1, 5);

insert into responsaveis(responsaveisFK, tarefaFK) values
(1, 3),
(2, 4);

insert into progresso(status, dataAndamento, dataConclusao) values
('em andamento', '20-05-2023', '25-05-2023'),
('concluida', '19-06-2023', '23-06-2023');

insert into status (feita, data_Mod, progressoFK) values
('não', '18-05-2023', 2),
('sim', '17-06-2023', 3);

insert into foto_tarefa(link_foto) values
('https://www.fictitiouslink123.com/'),
('https://www.madeuplink456.org/');


# 1> # 
select * from tarefa where id not in
(select t.id from tarefa t join progressos ts on t.id = ts.tarefa_fk);

# 2> #
select l.id, count(*) from locais l join
tarefa t on l.id = t.locais_FK group by t.locais_FK having count(l.id)>2;

# 3 > #
select u.id,count(*) from tarefa t join responsavel r on t.id = r.responsavel_fk join usuarios u on r.responsavel_FK = u.id group by u.id having count(u.id)>=2;

# 4 > #
select e.id, t.id from tarefa t join locais l on t.locais_FK = l.id join eventos e on l.id = e.localFk join progressos ts on t.id = ts.tarefa_fk
where e.inicio > now() and ts.status_FK != '4' group by e.id,t.id;

# 5 > #
select l.id, count(*) from locais l join tarefa t on l.id = t.locais_FK group by l.id;

# 6 > #
select l.id, count(*) from locais l join tarefa t on l.id = t.locais_FK join progressos ts on t.id = ts.tarefa_fk where ts.status_FK = 4 group by l.id;

# 7 > #
select u.id,count(*) from usuarios u join responsavel tr on u.id = tr.responsavel_fk group by u.id;

# 8 > #
select u.id,count(*) from usuarios u join responsavel tr on u.id = tr.responsavel_fk join tarefa t on tr.responsavel_fk = t.id join progressos ts on t.id = ts.tarefa_fk where ts.status_fk = '4' group by u.id;

# 9 > #
select , AVG(d.qnt) from locais l join (select locais_FK, month(prazo)as mes,count() as qnt from tarefa group by mes,locais_FK) d on l.id = d.locais_FK group by d.mes,l.id;