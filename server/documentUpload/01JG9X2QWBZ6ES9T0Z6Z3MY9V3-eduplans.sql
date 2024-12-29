-- Adminer 4.8.1 PostgreSQL 16.4 (Debian 16.4-1.pgdg120+1) dump

INSERT INTO "Availability" ("id", "beginDate", "endDate", "isFavorite", "createdAt", "updatedAt", "userId") VALUES
('c271d095-9807-4219-a4f9-01afc47f2179',	'2024-12-17 07:00:00+00',	'2024-12-17 11:00:00+00',	'f',	'2024-12-13 15:39:01.917+00',	'2024-12-13 15:39:01.917+00',	'0dfb0998-767e-43ac-a8dc-14ac65713c0b'),
('77e6b8d7-a0fa-4459-aaf9-e1f5be952ba7',	'2024-12-17 12:00:00+00',	'2024-12-17 17:00:00+00',	'f',	'2024-12-13 15:39:01.917+00',	'2024-12-13 15:39:01.917+00',	'0dfb0998-767e-43ac-a8dc-14ac65713c0b');

INSERT INTO "Branch" ("id", "name", "nbHoursQuota", "createdAt", "updatedAt") VALUES
('7171f647-4363-4ab5-984c-380cd90fa56a',	'Ingénierie du web',	110,	'2024-12-13 15:29:02.961+00',	'2024-12-13 15:29:02.961+00'),
('4fbc6aa6-a534-477c-8ec6-f4bd4b168d7b',	'Mobilité et objets connectés',	190,	'2024-12-13 15:29:02.962+00',	'2024-12-13 15:29:02.962+00'),
('862822bf-4e83-4a78-8d4f-a8c1a440a4b2',	'Marketing digital',	90,	'2024-12-13 15:29:02.962+00',	'2024-12-13 15:29:02.962+00');

INSERT INTO "Class" ("id", "name", "createdAt", "updatedAt", "branchId") VALUES
('ba21bf33-edc3-4f04-9871-6bcee6d3a7ca',	'Mobilité et objets connectés 1',	'2024-12-13 15:29:02.974+00',	'2024-12-13 15:29:02.974+00',	'4fbc6aa6-a534-477c-8ec6-f4bd4b168d7b'),
('70a2be64-b94a-4406-b700-25d30f1a450c',	'Marketing digital 2',	'2024-12-13 15:29:02.975+00',	'2024-12-13 15:29:02.975+00',	'862822bf-4e83-4a78-8d4f-a8c1a440a4b2'),
('339166ef-d72d-4b7e-966f-d1058d36a8e8',	'Ingénierie du web 2',	'2024-12-13 15:29:02.974+00',	'2024-12-13 15:29:02.974+00',	'7171f647-4363-4ab5-984c-380cd90fa56a'),
('1e2b5dd2-72e2-4730-a24f-d2e45103f651',	'Mobilité et objets connectés 2',	'2024-12-13 15:29:02.974+00',	'2024-12-13 15:29:02.974+00',	'4fbc6aa6-a534-477c-8ec6-f4bd4b168d7b'),
('63b9e30f-e87f-4e5c-acb2-3db6ac65bf79',	'Ingénierie du web 1',	'2024-12-13 15:29:02.974+00',	'2024-12-13 15:29:02.974+00',	'7171f647-4363-4ab5-984c-380cd90fa56a'),
('7a2eba4f-857e-481d-b006-253c468fc9c1',	'Marketing digital 1',	'2024-12-13 15:29:02.974+00',	'2024-12-13 15:29:02.974+00',	'862822bf-4e83-4a78-8d4f-a8c1a440a4b2');

INSERT INTO "Period" ("id", "beginDate", "endDate", "createdAt", "updatedAt") VALUES
('ed14274a-d8f8-425f-90a0-0c07656cfbed',	'2024-09-02 00:00:00+00',	'2024-12-31 00:00:00+00',	'2024-12-13 15:29:02.978+00',	'2024-12-13 15:29:02.978+00'),
('6c438cad-d25b-438b-b1d7-ab77ed9d0d49',	'2025-01-01 00:00:00+00',	'2025-06-30 00:00:00+00',	'2024-12-13 15:29:02.978+00',	'2024-12-13 15:29:02.978+00');


INSERT INTO "Room" ("id", "name", "createdAt", "updatedAt", "roomId") VALUES
('89f09f2c-900e-492d-979c-3ac0de5c160d',	'A01',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('b6db7b58-11e2-4999-8acd-2121b0675550',	'B01',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('7ed6687f-31e7-4d58-bb7c-115b1bea2a87',	'A02',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('9a41fecb-4e5a-4672-8412-8846307425c2',	'B02',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('da8026e5-9fb8-49a7-8f18-5a4805b86428',	'A03',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('840c3541-f4f5-4821-8d45-8ff15674473c',	'B03',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('a8525aad-e931-4326-b329-aef1ac0217b8',	'A04',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('61b2a518-6ee5-4e03-8c1b-d54b75c7f065',	'B04',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('9c350fbb-9127-4574-964c-6b8f56391f90',	'A05',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('e3bc0285-80f1-4c7f-b6e9-6cf9a89e9847',	'B05',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('55d88b65-0a59-43f5-a4ae-7e21eab8060d',	'A06',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('26aa6cfc-152a-4695-b54a-58ca8ed17f80',	'B06',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('a08c2833-8785-49c0-944e-ac3b94c4a47b',	'A07',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('56c14b5d-7d8a-447a-99f4-e444f4954122',	'B07',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('f658ccde-b22c-417e-bbed-ccbfcb1efa8b',	'A08',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('da380baf-64bf-4990-a3e6-7c09faa31307',	'B08',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('a32379e3-5a5d-4de1-9f46-99f0d877f9b3',	'A09',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('c637512f-ed34-4b4a-8bd0-e119c3f4d4c6',	'B09',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('16addd4f-8b74-41b4-aebb-413316fd43cf',	'A10',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL),
('a279b9b5-b265-4db6-9dbe-25b11308fd06',	'B10',	'2024-12-13 15:29:02.955+00',	'2024-12-13 15:29:02.955+00',	NULL);

INSERT INTO "School" ("id", "name", "createdAt", "updatedAt") VALUES
('94832c71-9a38-4da1-84ec-48a4d2d1650f',	'DCODE',	'2024-12-13 15:29:02.959+00',	'2024-12-13 15:29:02.959+00');

INSERT INTO "SchoolDayClass" ("id", "date", "createdAt", "updatedAt", "classId") VALUES
('00f7798f-6e1a-4afb-993f-c6d9abd945e3',	'2024-12-09',	'2024-12-13 15:30:33.086+00',	'2024-12-13 15:30:33.086+00',	'339166ef-d72d-4b7e-966f-d1058d36a8e8'),
('67afa902-39c1-4f0a-85fa-0d95509c4b01',	'2024-12-16',	'2024-12-13 15:30:33.086+00',	'2024-12-13 15:30:33.086+00',	'339166ef-d72d-4b7e-966f-d1058d36a8e8'),
('530fe462-25d1-4904-a9b9-6433eede7eb4',	'2024-12-17',	'2024-12-13 15:37:20.023+00',	'2024-12-13 15:37:20.023+00',	'63b9e30f-e87f-4e5c-acb2-3db6ac65bf79');


INSERT INTO "Subject" ("id", "name", "nbHoursQuota", "nbHoursQuotaExam", "color", "createdAt", "updatedAt", "branchId") VALUES
('6c2763f0-2c14-4a4b-9e2b-9626de05a40f',	'Programmation web en PHP',	40,	5,	'#FF5733',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'7171f647-4363-4ab5-984c-380cd90fa56a'),
('4f5fb290-0ee1-4714-87bd-3139214a5991',	'Développement web en JavaScript',	50,	10,	'#33FF57',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'7171f647-4363-4ab5-984c-380cd90fa56a'),
('028f8838-1c20-4594-b86b-3ea8da9dbdbc',	'Conception de bases de données SQL',	20,	5,	'#5733FF',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'7171f647-4363-4ab5-984c-380cd90fa56a'),
('13be11db-fd1a-433d-bb6c-2d08644d178b',	'Programmation embarquée en C',	50,	5,	'#F1C40F',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'4fbc6aa6-a534-477c-8ec6-f4bd4b168d7b'),
('11f9746d-93a4-4783-8510-171268709438',	'Développement d’applications mobiles Android',	70,	10,	'#9B59B6',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'4fbc6aa6-a534-477c-8ec6-f4bd4b168d7b'),
('2d1e6d22-09b8-4a08-adc0-142e52bf9138',	'Développement d’applications mobiles iOS (Swift)',	70,	10,	'#E74C3C',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'4fbc6aa6-a534-477c-8ec6-f4bd4b168d7b'),
('f1e32655-ecd5-45ca-8749-567b56ec423f',	'Publicité en ligne (Google Ads, Facebook Ads)',	40,	5,	'#34495E',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'862822bf-4e83-4a78-8d4f-a8c1a440a4b2'),
('3a7d4940-31df-419e-aa06-c86473f7ab95',	'Stratégie de marketing digital',	40,	5,	'#1ABC9C',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'862822bf-4e83-4a78-8d4f-a8c1a440a4b2'),
('699fa199-a1c3-4dfe-b30b-0fd8256001bb',	'Analyse des données et Google Analytics',	10,	3,	'#F39C12',	'2024-12-13 15:29:02.967+00',	'2024-12-13 15:29:02.967+00',	'862822bf-4e83-4a78-8d4f-a8c1a440a4b2');

INSERT INTO "SubjectClass" ("id", "createdAt", "updatedAt", "classId", "periodId", "subjectId", "teacherId") VALUES
('66b8c0c0-3d80-43bf-8bfb-11912c4663e6',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'339166ef-d72d-4b7e-966f-d1058d36a8e8',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'6c2763f0-2c14-4a4b-9e2b-9626de05a40f',	'd056a8f1-8628-400c-aa10-21f656d9d35b'),
('a82c56ed-f4c3-4fad-847f-9e2906b88542',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'63b9e30f-e87f-4e5c-acb2-3db6ac65bf79',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'6c2763f0-2c14-4a4b-9e2b-9626de05a40f',	'0dfb0998-767e-43ac-a8dc-14ac65713c0b'),
('3f200deb-4ccc-4d16-90f6-3c165f4cdb5b',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'339166ef-d72d-4b7e-966f-d1058d36a8e8',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'4f5fb290-0ee1-4714-87bd-3139214a5991',	'374d3b1d-82f6-41c2-b5a9-8fe894ab5da3'),
('625ffd28-7029-43a9-bb5e-ab5ac48b3c94',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'63b9e30f-e87f-4e5c-acb2-3db6ac65bf79',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'4f5fb290-0ee1-4714-87bd-3139214a5991',	'bb36c024-faa0-4517-a3e0-6525bf6f2ded'),
('d6d86a70-c829-4d72-97ce-7803e6a8c36e',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'339166ef-d72d-4b7e-966f-d1058d36a8e8',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'028f8838-1c20-4594-b86b-3ea8da9dbdbc',	'8f8e207a-f7c7-42e2-9baf-21946f462dc8'),
('17205d6c-77b5-4e78-a2cb-6ad11ff446f7',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'63b9e30f-e87f-4e5c-acb2-3db6ac65bf79',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'028f8838-1c20-4594-b86b-3ea8da9dbdbc',	'0d8f7cfc-b3eb-405e-8fa0-f35ce425b8a0'),
('5dbee8ab-9d69-47c6-b538-71df8d4f21d5',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'ba21bf33-edc3-4f04-9871-6bcee6d3a7ca',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'13be11db-fd1a-433d-bb6c-2d08644d178b',	'd056a8f1-8628-400c-aa10-21f656d9d35b'),
('82e62593-b532-4dd4-a051-baf7ba1bc1ac',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'1e2b5dd2-72e2-4730-a24f-d2e45103f651',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'13be11db-fd1a-433d-bb6c-2d08644d178b',	'0dfb0998-767e-43ac-a8dc-14ac65713c0b'),
('58560207-fd7f-4b38-8cbf-c56575388ddf',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'ba21bf33-edc3-4f04-9871-6bcee6d3a7ca',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'11f9746d-93a4-4783-8510-171268709438',	'374d3b1d-82f6-41c2-b5a9-8fe894ab5da3'),
('be2d6299-bb7e-427a-8ce9-c915b04c25cf',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'1e2b5dd2-72e2-4730-a24f-d2e45103f651',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'11f9746d-93a4-4783-8510-171268709438',	'bb36c024-faa0-4517-a3e0-6525bf6f2ded'),
('7e6879bb-5c54-410e-91b2-9030e4380696',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'ba21bf33-edc3-4f04-9871-6bcee6d3a7ca',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'2d1e6d22-09b8-4a08-adc0-142e52bf9138',	'8f8e207a-f7c7-42e2-9baf-21946f462dc8'),
('2668709f-89b9-440d-8500-bba365937382',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'1e2b5dd2-72e2-4730-a24f-d2e45103f651',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'2d1e6d22-09b8-4a08-adc0-142e52bf9138',	'0d8f7cfc-b3eb-405e-8fa0-f35ce425b8a0'),
('b79983ba-2c6c-4575-ad0c-2fc8d8f22e6b',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'70a2be64-b94a-4406-b700-25d30f1a450c',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'f1e32655-ecd5-45ca-8749-567b56ec423f',	'd056a8f1-8628-400c-aa10-21f656d9d35b'),
('68ca51dd-82cc-41ea-b95f-f899fc7905b7',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'7a2eba4f-857e-481d-b006-253c468fc9c1',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'f1e32655-ecd5-45ca-8749-567b56ec423f',	'0dfb0998-767e-43ac-a8dc-14ac65713c0b'),
('0ced19fa-bf79-4a71-8cca-ac28aa7d5962',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'70a2be64-b94a-4406-b700-25d30f1a450c',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'3a7d4940-31df-419e-aa06-c86473f7ab95',	'374d3b1d-82f6-41c2-b5a9-8fe894ab5da3'),
('c28be31a-09c8-4de1-8a55-54f87398a9e7',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'7a2eba4f-857e-481d-b006-253c468fc9c1',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'3a7d4940-31df-419e-aa06-c86473f7ab95',	'bb36c024-faa0-4517-a3e0-6525bf6f2ded'),
('49931d0c-3ba0-48ed-84a4-03f9440f7644',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'70a2be64-b94a-4406-b700-25d30f1a450c',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'699fa199-a1c3-4dfe-b30b-0fd8256001bb',	'8f8e207a-f7c7-42e2-9baf-21946f462dc8'),
('ededef24-aca9-4559-95cb-562055d0ae56',	'2024-12-13 15:29:02.983+00',	'2024-12-13 15:29:02.983+00',	'7a2eba4f-857e-481d-b006-253c468fc9c1',	'ed14274a-d8f8-425f-90a0-0c07656cfbed',	'699fa199-a1c3-4dfe-b30b-0fd8256001bb',	'0d8f7cfc-b3eb-405e-8fa0-f35ce425b8a0');


INSERT INTO "User" ("id", "lastname", "firstname", "email", "role", "createdAt", "updatedAt", "classId") VALUES
('d056a8f1-8628-400c-aa10-21f656d9d35b',	'Zeknine',	'Jugurtha',	'jug@mail.fr',	'professor',	'2024-12-13 15:29:02.939+00',	'2024-12-13 15:29:02.939+00',	NULL),
('3f8f59f6-911a-49c5-95cb-e4c06516747d',	'John',	'Doe',	'doe@mail.fr',	'manager',	'2024-12-13 15:29:02.94+00',	'2024-12-13 15:29:02.94+00',	NULL),
('0dfb0998-767e-43ac-a8dc-14ac65713c0b',	'Keeling',	'Jaquan',	'Rogers68@mail.fr',	'professor',	'2024-12-13 15:29:02.947+00',	'2024-12-13 15:29:02.947+00',	NULL),
('374d3b1d-82f6-41c2-b5a9-8fe894ab5da3',	'Gleason',	'Myrtle',	'Orie_Schuppe@mail.fr',	'professor',	'2024-12-13 15:29:02.949+00',	'2024-12-13 15:29:02.949+00',	NULL),
('bb36c024-faa0-4517-a3e0-6525bf6f2ded',	'Prohaska',	'Vivianne',	'Leonel.Farrell@mail.fr',	'professor',	'2024-12-13 15:29:02.95+00',	'2024-12-13 15:29:02.95+00',	NULL),
('8f8e207a-f7c7-42e2-9baf-21946f462dc8',	'Balistreri-Dicki',	'Simone',	'Meaghan75@mail.fr',	'professor',	'2024-12-13 15:29:02.952+00',	'2024-12-13 15:29:02.952+00',	NULL),
('0d8f7cfc-b3eb-405e-8fa0-f35ce425b8a0',	'Kessler',	'Edwina',	'Mikel_Dach59@mail.fr',	'professor',	'2024-12-13 15:29:02.954+00',	'2024-12-13 15:29:02.954+00',	NULL),
('9344ce80-7e6b-462f-bb88-6e0aadf9ee37',	'Mouhamad',	'Zaid',	'zaid@mail.fr',	'student',	'2024-12-13 15:29:02.977+00',	'2024-12-13 15:29:02.977+00',	'63b9e30f-e87f-4e5c-acb2-3db6ac65bf79');

DROP TABLE IF EXISTS "WorkHour";
CREATE TABLE "public"."WorkHour" (
    "id" uuid NOT NULL,
    "beginDate" timestamptz NOT NULL,
    "endDate" timestamptz NOT NULL,
    "createdAt" timestamptz NOT NULL,
    "updatedAt" timestamptz NOT NULL,
    "roomId" uuid,
    "schoolDayClassId" uuid,
    "subjectClassId" uuid,
    CONSTRAINT "WorkHour_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "WorkHour" ("id", "beginDate", "endDate", "createdAt", "updatedAt", "roomId", "schoolDayClassId", "subjectClassId") VALUES
('59e22f79-0ab8-470c-9fb4-ae44ff1b5956',	'2024-12-17 07:00:00+00',	'2024-12-17 08:00:00+00',	'2024-12-13 15:37:38.19+00',	'2024-12-13 15:37:38.19+00',	'89f09f2c-900e-492d-979c-3ac0de5c160d',	'530fe462-25d1-4904-a9b9-6433eede7eb4',	'a82c56ed-f4c3-4fad-847f-9e2906b88542');

ALTER TABLE ONLY "public"."WorkHour" ADD CONSTRAINT "WorkHour_roomId_fkey" FOREIGN KEY ("roomId") REFERENCES "Room"(id) ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE;
ALTER TABLE ONLY "public"."WorkHour" ADD CONSTRAINT "WorkHour_schoolDayClassId_fkey" FOREIGN KEY ("schoolDayClassId") REFERENCES "SchoolDayClass"(id) ON UPDATE CASCADE ON DELETE CASCADE NOT DEFERRABLE;
ALTER TABLE ONLY "public"."WorkHour" ADD CONSTRAINT "WorkHour_subjectClassId_fkey" FOREIGN KEY ("subjectClassId") REFERENCES "SubjectClass"(id) ON UPDATE CASCADE ON DELETE SET NULL NOT DEFERRABLE;

-- 2024-12-13 15:53:39.940497+00
