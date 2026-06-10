CREATE INDEX IF NOT EXISTS idx_spot_anime_id_id
ON public.spot USING btree (anime_id, id);
