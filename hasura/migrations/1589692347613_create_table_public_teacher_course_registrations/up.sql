CREATE TABLE "public"."teacher_course_registrations"("teacher_id" integer NOT NULL, "course_id" integer NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("teacher_id","course_id") , FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers"("id") ON UPDATE cascade ON DELETE cascade, FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON UPDATE cascade ON DELETE cascade);
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
CREATE TRIGGER "set_public_teacher_course_registrations_updated_at"
BEFORE UPDATE ON "public"."teacher_course_registrations"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_teacher_course_registrations_updated_at" ON "public"."teacher_course_registrations" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
