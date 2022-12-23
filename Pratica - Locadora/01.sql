CREATE TABLE "public.addresses" (
	"id" serial NOT NULL,
	"zipCode" TEXT NOT NULL,
	"state" TEXT NOT NULL,
	"city" TEXT NOT NULL,
	"neighborhood" TEXT NOT NULL,
	"number" integer NOT NULL,
	"complement" TEXT NOT NULL,
	CONSTRAINT "addresses_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.returnRental" (
	"id" serial NOT NULL,
	"rentalId" integer NOT NULL,
	"returnDate" DATE NOT NULL,
	CONSTRAINT "returnRental_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.categories" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	CONSTRAINT "categories_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.customers" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL,
	"phone" integer NOT NULL,
	"address" integer NOT NULL,
	CONSTRAINT "customers_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.actors" (
	"id" serial NOT NULL,
	"name" TEXT NOT NULL UNIQUE,
	"originCountry" TEXT NOT NULL,
	"birthDay" DATE NOT NULL,
	CONSTRAINT "actors_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.movieStars" (
	"id" serial NOT NULL,
	"movieId" integer NOT NULL,
	"actorId" integer NOT NULL,
	CONSTRAINT "movieStars_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.feedBack" (
	"id" serial NOT NULL,
	"movieId" integer NOT NULL,
	"customerId" integer NOT NULL,
	"movieGrade" integer NOT NULL,
	"attendanceGrade" integer NOT NULL,
	CONSTRAINT "feedBack_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.disc" (
	"id" serial NOT NULL,
	"movieId" integer NOT NULL,
	"barCode" TEXT NOT NULL UNIQUE,
	"number" TEXT NOT NULL UNIQUE,
	CONSTRAINT "disc_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.movies" (
	"id" serial NOT NULL,
	"title" TEXT NOT NULL UNIQUE,
	"category" integer NOT NULL,
	CONSTRAINT "movies_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.rentals" (
	"id" serial NOT NULL,
	"discId" integer NOT NULL,
	"customerId" integer NOT NULL,
	"rentalDate" DATE NOT NULL,
	CONSTRAINT "rentals_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.phones" (
	"id" serial NOT NULL,
	CONSTRAINT "phones_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "returnRental" ADD CONSTRAINT "returnRental_fk0" FOREIGN KEY ("rentalId") REFERENCES "rentals"("id");


ALTER TABLE "customers" ADD CONSTRAINT "customers_fk0" FOREIGN KEY ("phone") REFERENCES "phones"("id");
ALTER TABLE "customers" ADD CONSTRAINT "customers_fk1" FOREIGN KEY ("address") REFERENCES "addresses"("id");


ALTER TABLE "movieStars" ADD CONSTRAINT "movieStars_fk0" FOREIGN KEY ("movieId") REFERENCES "movies"("id");
ALTER TABLE "movieStars" ADD CONSTRAINT "movieStars_fk1" FOREIGN KEY ("actorId") REFERENCES "actors"("id");

ALTER TABLE "feedBack" ADD CONSTRAINT "feedBack_fk0" FOREIGN KEY ("movieId") REFERENCES "movies"("id");
ALTER TABLE "feedBack" ADD CONSTRAINT "feedBack_fk1" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "disc" ADD CONSTRAINT "disc_fk0" FOREIGN KEY ("movieId") REFERENCES "movies"("id");

ALTER TABLE "movies" ADD CONSTRAINT "movies_fk0" FOREIGN KEY ("category") REFERENCES "categories"("id");

ALTER TABLE "rentals" ADD CONSTRAINT "rentals_fk0" FOREIGN KEY ("discId") REFERENCES "disc"("id");
ALTER TABLE "rentals" ADD CONSTRAINT "rentals_fk1" FOREIGN KEY ("customerId") REFERENCES "customers"("id");