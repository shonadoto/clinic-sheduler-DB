-- Active: 1711554668035@@127.0.0.1@5432@postgres@medical_center

INSERT INTO Clients
  (name, birth_date, gender, phone_number, email)
VALUES
  ('Иванов Иван', '1990-05-15', 'М', '1234567890', 'ivanov@example.com'),
  ('Петров Петр', '1985-08-20', 'М', '9876543210', 'petrov@example.com'),
  ('Сидорова Анна', '1995-03-10', 'Ж', '5551234567', 'sidorova@example.com'),
  ('Козлова Ольга', '1988-12-05', 'Ж', '7778889999', 'kozlova@example.com'),
  ('Николаев Николай', '1982-07-25', 'М', '6665554444', 'nikolaev@example.com'),
  ('Григорьев Григорий', '1993-11-30', 'М', '1112223333', 'grigoryev@example.com'),
  ('Павлова Мария', '1979-04-18', 'Ж', '3334445555', 'pavlova@example.com'),
  ('Кузнецов Иван', '1970-09-08', 'М', '9990001111', 'kuznetsov@example.com'),
  ('Медведева Елена', '1987-02-12', 'Ж', '1231234567', 'medvedeva@example.com'),
  ('Андреев Андрей', '1984-06-23', 'М', '9876543210', 'andreev@example.com'),
  ('Романов Роман', '1975-08-15', 'М', '4445556666', 'romanov@example.com'),
  ('Тарасова Ольга', '1992-01-20', 'Ж', '7778889999', 'tarasova@example.com'),
  ('Семенов Семен', '1980-03-05', 'М', '8887776666', 'semenov@example.com'),
  ('Жукова Жанна', '1983-10-28', 'Ж', '2223334444', 'zhukova@example.com'),
  ('Васильев Василий', '1978-06-14', 'М', '5556667777', 'vasilyev@example.com'),
  ('Семенов Алексей', '1984-06-18', 'М', '7778889990', 'semenov@example.com'),
  ('Козлова Мария', '1990-09-23', 'Ж', '5556667778', 'kozlova@example.com'),
  ('Николаева Ирина', '1981-12-10', 'Ж', '2223334446', 'nikolaeva@example.com'),
  ('Белов Владимир', '1978-03-14', 'М', '9998887774', 'belov@example.com'),
  ('Зайцева Елена', '1989-08-30', 'Ж', '3334445552', 'zaytseva@example.com'),
  ('Григорьев Андрей', '1985-01-25', 'М', '6667778883', 'grigoriev@example.com'),
  ('Максимова Ольга', '1979-04-07', 'Ж', '4445556668', 'maximova@example.com'),
  ('Романов Павел', '1992-11-12', 'М', '1112223339', 'romanov@example.com'),
  ('Борисова Анна', '1986-07-28', 'Ж', '8889990007', 'borisova@example.com'),
  ('Сергеев Сергей', '1983-02-15', 'М', '5556667774', 'sergeev@example.com'),
  ('Андреева Наталья', '1991-05-20', 'Ж', '7778889992', 'andreeva@example.com'),
  ('Тимофеева Ольга', '1977-09-03', 'Ж', '2223334448', 'timofeeva@example.com'),
  ('Артемьев Артем', '1988-04-28', 'М', '9998887771', 'artemyev@example.com'),
  ('Васильев Владислав', '1982-08-14', 'М', '4445556663', 'vasilyev@example.com'),
  ('Дмитриева Екатерина', '1994-03-19', 'Ж', '8889990005', 'dmitrieva@example.com');

INSERT INTO Doctors
  (name, birth_date, gender, phone_number, email, price_for_hour)
VALUES
  ('Петрова Елена', '1978-06-18', 'Ж', '7778889990', 'petrova@example.com', 2100),
  ('Сидоров Иван', '1984-09-23', 'М', '5556667778', 'sidorov@example.com', 2300),
  ('Смирнова Мария', '1972-12-10', 'Ж', '2223334446', 'smirnova@example.com', 2200),
  ('Кузнецов Александр', '1977-03-14', 'М', '9998887774', 'kuznetsov@example.com', 2400),
  ('Морозова Екатерина', '1989-08-30', 'Ж', '3334445552', 'morozova@example.com', 2200),
  ('Васильева Ольга', '1985-01-25', 'Ж', '6667778883', 'vasilieva@example.com', 2100),
  ('Новиков Андрей', '1979-04-07', 'М', '4445556668', 'novikov@example.com', 2300),
  ('Павлова Анна', '1992-11-12', 'Ж', '1112223339', 'pavlova@example.com', 2400),
  ('Александрова Екатерина', '1986-07-28', 'Ж', '8889990007', 'alexandrova@example.com', 2200),
  ('Михайлов Иван', '1983-02-15', 'М', '5556667774', 'mikhailov@example.com', 2100),
  ('Егорова Татьяна', '1991-05-20', 'Ж', '7778889992', 'egorova@example.com', 2300),
  ('Поляков Иван', '1977-09-03', 'М', '2223334448', 'polyakov@example.com', 2400),
  ('Алексеева Елена', '1988-04-28', 'Ж', '9998887771', 'alekseeva@example.com', 2200),
  ('Федоров Владимир', '1982-08-14', 'М', '4445556663', 'fedorov@example.com', 2100),
  ('Сергеев Иван', '1994-03-19', 'М', '8889990005', 'sergeev@example.com', 2300);

CREATE OR REPLACE FUNCTION version_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Doctors
    SET valid_to = CURRENT_DATE
    WHERE name = NEW.name
      AND birth_date = NEW.birth_date
      AND valid_to = '9999-12-31';

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER versioning_trigger
BEFORE INSERT ON Doctors
FOR EACH ROW 
EXECUTE FUNCTION version_trigger_function();

INSERT INTO Doctors
  (name, birth_date, gender, phone_number, email, price_for_hour)
VALUES
  ('Петрова Елена', '1978-06-18', 'Ж', '777888990', 'petrova@example.com', 500000)
 

INSERT INTO Services
  (name, price)
VALUES
  ('Прием врача общей практики', 1500),
  ('УЗИ', 2000),
  ('Консультация кардиолога', 2500),
  ('Прием невролога', 1800),
  ('Анализ крови', 1000),
  ('МРТ', 3000),
  ('Консультация гинеколога', 2200),
  ('Рентген', 1800),
  ('Прием терапевта', 1600),
  ('ЭКГ', 1700),
  ('Прием офтальмолога', 2000),
  ('Ультразвуковая диагностика', 2100),
  ('Массаж', 1500),
  ('Процедуры физиотерапии', 1900),
  ('Консультация эндокринолога', 2300),
  ('Прием дерматолога', 1700),
  ('Консультация хирурга', 2400),
  ('УЗД', 2200),
  ('Флюорография', 1600),
  ('Лечебный массаж', 1800),
  ('Прием диетолога', 2000),
  ('КТ', 2800),
  ('Реабилитация после операции', 3000),
  ('Инъекции', 1200),
  ('Прием психотерапевта', 2500),
  ('Онкологические консультации', 2700),
  ('Консультация педиатра', 1500),
  ('Уход за пожилыми людьми', 1900),
  ('Ультразвуковая чистка лица', 2100),
  ('Лечение аллергии', 2200);


INSERT INTO Competence
  (service_id, doctor_id)
VALUES
  (8, 3),
  (28, 6),
  (22, 15),
  (11, 14),
  (13, 6),
  (7, 1),
  (21, 3),
  (15, 5),
  (15, 5),
  (16, 15),
  (26, 12),
  (27, 5),
  (17, 1),
  (22, 15),
  (6, 10),
  (2, 1),
  (30, 11),
  (12, 9),
  (22, 3),
  (7, 8),
  (13, 1),
  (21, 2),
  (26, 6),
  (25, 3),
  (18, 7),
  (20, 8),
  (29, 13),
  (4, 11),
  (2, 13),
  (27, 6),
  (20, 2),
  (22, 2),
  (8, 14),
  (25, 9),
  (7, 14),
  (27, 14),
  (29, 3),
  (15, 13),
  (8, 5),
  (18, 8),
  (15, 2),
  (13, 2),
  (7, 6),
  (7, 7),
  (19, 14),
  (30, 5),
  (1, 13),
  (12, 5),
  (22, 7),
  (29, 2),
  (1, 7),
  (8, 13),
  (13, 8),
  (6, 4);


