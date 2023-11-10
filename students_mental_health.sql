-- Анализ психического здоровья студентов с помощью SQL


-- Подсчитаем количество записей в данных
select count(*) as total_records
from students;

-- Выводим первые 5 записей
select *
from students
limit 5;

-- Подсчитаем количество иностранных и местных студентов
select inter_dom, count(inter_dom) as count_inter_dom
from students
group by inter_dom;

-- Пишем запрос, чтобы просмотреть все записи, в которых inter_dom не является ни «Dom», ни «Inter».
select *
from students
where inter_dom not like 'D%' and inter_dom not like 'I%';

-- Посмотрим, из каких регионов приезжают иностранные студенты
select Region, count(inter_dom) as count_inter_dom
from students
where inter_dom = 'Inter'
group by Region;

-- Узнаем основную сводную статистику диагностических тестов для всех студентов.
select 	min(ToDep) as min_phq,
		max(ToDep) as max_phq,
        round(avg(ToDep), 2) as avg_phq,
		min(ToSC) as min_scs,
		max(ToSC) as max_scs,
        round(avg(ToSC), 2) as avg_scs,
        min(ToAS) as min_as,
        max(ToAS) as max_as,
        round(avg(ToAS), 2) as avg_as
from students;

-- Напишем запрос, который просматривает статистику каждой группы учащихся в одной таблице, не забывая избегать пустых строк.
select 	inter_dom,
		min(ToDep) as min_phq,
		max(ToDep) as max_phq,
        round(avg(ToDep), 2) as avg_phq,
		min(ToSC) as min_scs,
		max(ToSC) as max_scs,
        round(avg(ToSC), 2) as avg_scs,
        min(ToAS) as min_as,
        max(ToAS) as max_as,
        round(avg(ToAS), 2) as avg_as
from students
where inter_dom in ('Inter', 'Dom')
group by inter_dom;

-- Найдем средние баллы для каждой возрастной группы иностранных студентов и просмотрим их по порядку.
select 	Age,
		round(avg(ToDep), 2) as avg_phq,
        round(avg(ToSC), 2) as avg_scs,
        round(avg(ToAS), 2) as avg_as
from students
where inter_dom = 'Inter'
group by Age
order by Age;

-- Сделаем то же самое, что и в предыдущем запросе, но теперь на основе длительности пребывания в стране
select 	Stay,
		round(avg(ToDep), 2) as avg_phq,
        round(avg(ToSC), 2) as avg_scs,
        round(avg(ToAS), 2) as avg_as
from students
where inter_dom = 'Inter'
group by Stay
order by Stay;