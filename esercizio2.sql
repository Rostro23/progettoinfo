create database Esercizio2;
use Esercizio2;

create table gara(
codG integer auto_increment not null primary key,
luogo varchar(25) not null,
dataG integer not null,
disciplina varchar(25) not null

);

create table atleta(
codA integer auto_increment not null primary key,
nome varchar(25) not null,
nazione varchar(25) not null,
dataNascita integer not null
);

create table partecipazione(
codGara integer not null,
constraint partecipazioneGaraFK foreign key
partecipazione(codGara) references gara(codG)
on update cascade
on delete restrict,
codAtleta integer not null,
constraint partecipazioneAtletaFK foreign key
partecipazione(codAtleta) references atleta(codA)
on update cascade
on delete restrict,
constraint ChiaveMultipla primary key (codAtleta, codGara),
posizioneArrivo integer not null,
tempo integer not null

);

insert into atleta(nome,nazione,dataNascita) values ("Cristiano","POR",159860);
insert into atleta(nome,nazione,dataNascita) values ("Messi","ARG",167870);
insert into atleta(nome,nazione,dataNascita) values ("Criscito","ITA",234560);
insert into atleta(nome,nazione,dataNascita) values ("Samir","ROM",124320);
insert into atleta(nome,nazione,dataNascita) values ("Zaccagni","ITA",198030);
insert into gara(luogo,dataG,disciplina) values ("Milano",345230,"Mezzofondo");

insert into gara(luogo,dataG,disciplina) values ("Cortina",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Belluno",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Torino",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Roma",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Napoli",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Palermo",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Foggia",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Casale Monferrato",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Jesolo",345230,"Mezzofondo");
insert into gara(luogo,dataG,disciplina) values ("Roma",353490,"Maratona");
insert into gara(luogo,dataG,disciplina) values ("New York",432230,"Maratona");
insert into gara(luogo,dataG,disciplina) values ("New York",223480,"Corsa campestre");
insert into gara(luogo,dataG,disciplina) values ("Milano",560980,"Biathlon");
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(3,3,7,4560);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(3,2,4,4320);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(1,3,3,3350);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(4,4,4,4560);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(4,5,1,4120);

insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(5,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(6,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(7,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(8,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(9,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(10,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(11,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(12,5,1,4120);
insert into partecipazione(codGara,codAtleta,posizioneArrivo,tempo)values(13,5,1,4120);

/* avevo capito fossero gare di corsa, sostituisco nella consegna 1
la gara di discesa libera con la maratona.
le date e i tempi sono in timestamp (valori casuali), impongo che
160000 sia 00:00 1/1/1980 e le gare di sci di fondo siano mezzofondo */


select nome,dataNascita
from atleta, partecipazione
where atleta.codA = partecipazione.codAtleta and nazione="ITA" and codA not in(
select codAtleta
from partecipazione, gara
where partecipazione.codGara = gara.codG and codG in (select codG
from gara
where disciplina="Maratona"));

select nazione
from atleta
where dataNascita > 160000 and codA in
	(select CodA
	from atleta
	where codA in(
		select codA
		from partecipazione
		where codGara in
			(select codG
			from gara
			where disciplina="Mezzofondo")
            group by codA having
            count(codGara) > 10
            ))
group by codA 
having count(codA) > 5;



