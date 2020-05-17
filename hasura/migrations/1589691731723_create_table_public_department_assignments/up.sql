CREATE TABLE "public"."department_assignments"("department_id" integer NOT NULL, "teacher_id" integer NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("department_id","teacher_id") , FOREIGN KEY ("department_id") REFERENCES "public"."departments"("id") ON UPDATE cascade ON DELETE cascade, FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers"("id") ON UPDATE cascade ON DELETE cascade, UNIQUE ("department_id"), UNIQUE ("teacher_id"));
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
CREATE TRIGGER "set_public_department_assignments_updated_at"
BEFORE UPDATE ON "public"."department_assignments"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_department_assignments_updated_at" ON "public"."department_assignments" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
