CREATE TABLE "public.customers" (
	"id" serial NOT NULL,
	"fullName" TEXT NOT NULL,
	"cpf" TEXT NOT NULL UNIQUE,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	CONSTRAINT "customers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.customerAddresses" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	"street" TEXT NOT NULL,
	"number" integer NOT NULL,
	"complement" TEXT,
	"postalCode" TEXT NOT NULL,
	"cityId" integer NOT NULL,
	CONSTRAINT "customerAddresses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.city" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	"stateId" TEXT NOT NULL,
	CONSTRAINT "city_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.states" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	CONSTRAINT "states_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.customerPhones" (
	"customerId" integer NOT NULL,
	"number" TEXT NOT NULL,
	"type" TEXT NOT NULL CHECK ("type" = "landline" OR "type" = "Mobile")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.bankAccount" (
	"id" serial NOT NULL,
	"customerId" integer NOT NULL,
	"accountNumber" integer NOT NULL UNIQUE,
	"agency" integer NOT NULL,
	"openDate" TIMESTAMP NOT NULL,
	"closeDate" TIMESTAMP,
	CONSTRAINT "bankAccount_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.transactions" (
	"id" serial NOT NULL,
	"bankAccountId" integer NOT NULL,
	"amount" integer NOT NULL,
	"type" TEXT NOT NULL,
	"time" TIMESTAMP NOT NULL,
	"description" TEXT NOT NULL,
	"cancelled" bool NOT NULL,
	CONSTRAINT "transactions_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


CREATE TABLE "public.creditCards" (
	"id" serial NOT NULL,
	"bankAccount" integer NOT NULL,
	"name" TEXT NOT NULL,
	"number" varchar(16) NOT NULL UNIQUE,
	"securityCode" varchar(3) NOT NULL,
	"expirationMonth" integer NOT NULL,
	"expirationYear" integer NOT NULL,
	"password" TEXT NOT NULL,
	"limit" integer NOT NULL,
	CONSTRAINT "creditCards_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);


ALTER TABLE "customerAddresses" ADD CONSTRAINT "customerAddresses_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "customerAddresses" ADD CONSTRAINT "customerAddresses_fk1" FOREIGN KEY ("cityId") REFERENCES "city"("id");

ALTER TABLE "city" ADD CONSTRAINT "city_fk0" FOREIGN KEY ("stateId") REFERENCES "states"("id");


ALTER TABLE "customerPhones" ADD CONSTRAINT "customerPhones_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "bankAccount" ADD CONSTRAINT "bankAccount_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "transactions" ADD CONSTRAINT "transactions_fk0" FOREIGN KEY ("bankAccountId") REFERENCES "bankAccount"("id");

ALTER TABLE "creditCards" ADD CONSTRAINT "creditCards_fk0" FOREIGN KEY ("bankAccount") REFERENCES "bankAccount"("id");