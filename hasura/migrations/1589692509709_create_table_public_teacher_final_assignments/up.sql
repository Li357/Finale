CREATE TABLE "public"."teacher_final_assignments"("teacher_id" integer NOT NULL, "final_id" integer NOT NULL, "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("teacher_id","final_id") , FOREIGN KEY ("teacher_id") REFERENCES "public"."teachers"("id") ON UPDATE cascade ON DELETE cascade, FOREIGN KEY ("final_id") REFERENCES "public"."finals"("id") ON UPDATE cascade ON DELETE cascade);
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
CREATE TRIGGER "set_public_teacher_final_assignments_updated_at"
BEFORE UPDATE ON "public"."teacher_final_assignments"
FOR EACH ROW
EXECUTE PROCEDURE "public"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_public_teacher_final_assignments_updated_at" ON "public"."teacher_final_assignments" 
IS 'trigger to set value of column "updated_at" to current timestamp on row update';
