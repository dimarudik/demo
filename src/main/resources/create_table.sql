CREATE TABLE public.payments_tab (
    uuid character varying(255) NOT NULL,
    amount numeric(19,2),
    client_id character varying(255),
    status character varying(4),
    "timestamp" timestamp without time zone
);
ALTER TABLE public.payments_tab OWNER TO shard;
ALTER TABLE ONLY public.payments_tab ADD CONSTRAINT payments_tab_pkey PRIMARY KEY (uuid);