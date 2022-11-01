CREATE TABLE public.payments_tab (
    uuid character varying(255) NOT NULL,
    amount numeric(19,2),
    client_id character varying(255),
    status character varying(4),
    "timestamp" timestamp without time zone
);
ALTER TABLE public.payments_tab OWNER TO shard;
ALTER TABLE ONLY public.payments_tab ADD CONSTRAINT payments_tab_pkey PRIMARY KEY (uuid);

curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -d '{"clientId": "5-339CVCCVD", "amount": "3000", "timestamp": "2022-08-04T15:00:48", "status": "I"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -d '{"clientId": "5-6PAMOQ6V", "amount": "250", "timestamp": "2022-08-04T15:00:48", "status": "I"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -d '{"clientId": "5-ABELKTQM", "amount": "3000", "timestamp": "2022-08-04T15:00:48", "status": "I"}'
curl -i -X POST http://localhost:8080/payment -H "Content-Type:application/json" -d '{"clientId": "5-CLS23Y90", "amount": "4.09", "timestamp": "2022-08-04T15:00:48", "status": "I"}'
