-- 1) Расходы на персонал за промежуток времени
SELECT
  d.name AS doctor_name,
  CAST(SUM(EXTRACT(EPOCH FROM (s.end_timestamp - s.start_timestamp)) / 3600 * d.price_for_hour) AS INT) AS total_expenses
FROM
  Doctors d
  JOIN
  Competence c ON d.doctor_id = c.doctor_id
  JOIN
  Schedule s ON c.competence_id = s.competence_id
WHERE 
    s.start_timestamp BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY 
    ROLLUP(d.name)
ORDER BY d.name;

-- 2) Доходы за промежуток времени
SELECT
  SUM(s.price) AS total_income
FROM
  Appointments a
  JOIN
  Schedule sch ON a.window_id = sch.window_id
  JOIN
  Competence c ON sch.competence_id = c.competence_id
  JOIN
  Services s ON c.service_id = s.service_id
WHERE 
    sch.start_timestamp BETWEEN '2024-01-01' AND '2024-12-31';

-- 3) Список клиентов с количеством назначенных им приемов
SELECT
  c.name AS client_name,
  COUNT(a.id) AS appointments_count
FROM
  Clients c
  LEFT JOIN
  Appointments a ON c.client_id = a.client_id
GROUP BY 
    c.client_id
ORDER BY 
    appointments_count DESC;

-- 4) Список услуг и средней стоимости каждой услуги
SELECT
  s.name AS service_name,
  s.price AS average_price
FROM
  Services s
  JOIN
  Competence c ON s.service_id = c.service_id
GROUP BY 
    s.service_id;

-- 5) Список услуг, сортированный по количеству назначений на каждую услугу
SELECT
  s.name AS service_name,
  COUNT(a.id) AS appointments_count
FROM
  Services s
  LEFT JOIN
  Competence c ON s.service_id = c.service_id
  LEFT JOIN
  Schedule sch ON c.competence_id = sch.competence_id
  LEFT JOIN
  Appointments a ON sch.window_id = a.window_id
GROUP BY 
    s.service_id
ORDER BY 
    appointments_count DESC;

-- 6) Средний возраст клиентов, посещающих каждую услугу
SELECT
  s.name AS service_name,
  ROUND(AVG(EXTRACT(YEAR FROM AGE(a.birth_date)))) AS average_age
FROM
  Services s
  JOIN
  Competence c ON s.service_id = c.service_id
  JOIN
  Schedule sch ON c.competence_id = sch.competence_id
  JOIN
  Appointments app ON sch.window_id = app.window_id
  JOIN
  Clients a ON app.client_id = a.client_id
GROUP BY 
    s.service_id;

-- 7) Список клиентов, у которых количество приемов больше среднего
SELECT
  c.name AS client_name,
  COUNT(a.id) AS appointments_count
FROM
  Clients c
  LEFT JOIN
  Appointments a ON c.client_id = a.client_id
GROUP BY 
    c.client_id
HAVING 
    COUNT(a.id) > (SELECT
  AVG(appointments_count)
FROM
  (SELECT
    COUNT(id) AS appointments_count
  FROM
    Appointments
  GROUP BY client_id) AS subquery);

-- 8) Ранжирование клиентов по размеру трат
SELECT
  client_id,
  name,
  total_spent,
  RANK() OVER (ORDER BY total_spent DESC) AS spending_rank
FROM
  (
    SELECT
    c.client_id,
    c.name,
    SUM(s.price) AS total_spent
  FROM
    Clients c
    JOIN
    Appointments a ON c.client_id = a.client_id
    JOIN
    Schedule sch ON a.window_id = sch.window_id
    JOIN
    Competence co ON sch.competence_id = co.competence_id
    JOIN
    Services s ON co.service_id = s.service_id
  GROUP BY
        c.client_id, c.name
) AS client_spending;

-- 9) Врачи с самой высокой средней стоимостью услуг
SELECT
  doctor_id,
  name,
  ROUND(average_service_price) AS average_service_price
FROM
  (
    SELECT
    d.doctor_id,
    d.name,
    AVG(s.price) AS average_service_price
  FROM
    Doctors d
    JOIN
    Competence c ON d.doctor_id = c.doctor_id
    JOIN
    Services s ON c.service_id = s.service_id
  GROUP BY
        d.doctor_id, d.name
) AS doctor_service_prices
WHERE
    average_service_price = (
        SELECT
  MAX(average_service_price)
FROM
  (
            SELECT
    AVG(s.price) AS average_service_price
  FROM
    Doctors d
    JOIN
    Competence c ON d.doctor_id = c.doctor_id
    JOIN
    Services s ON c.service_id = s.service_id
  GROUP BY
                d.doctor_id
        ) AS max_average_price
    );

-- 10) Информация о клиентах определённого врача
SELECT
  c.name AS client_name,
  d.name AS doctor_name,
  s.name AS service_name,
  SUM(s.price) AS total_spent
FROM
  Clients c
  JOIN
  Appointments a ON c.client_id = a.client_id
  JOIN
  Schedule sch ON a.window_id = sch.window_id
  JOIN
  Competence co ON sch.competence_id = co.competence_id
  JOIN
  Doctors d ON co.doctor_id = d.doctor_id
  JOIN
  Services s ON co.service_id = s.service_id
WHERE
    d.doctor_id = 5
GROUP BY
    c.name, d.name, s.name;