CREATE TABLE "public"."finals"("id" serial NOT NULL, "mod" integer NOT NULL, "capacity" integer, "room" text NOT NULL, "course_id" integer NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON UPDATE cascade ON DELETE cascade, UNIQUE ("id"), UNIQUE ("course_id"));
CREATE OR REPLACE FUNCTION "public"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_public_finals_updated_at"
BEFORE UPDATE ON "public"."finals"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_finals_updated_at" ON "public"."finals" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
