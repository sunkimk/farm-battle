-- 农场大作战 · 联网总榜
-- 在 Supabase 项目的 SQL Editor 里整段运行一次即可。

create table if not exists public.scores (
  id         bigint generated always as identity primary key,
  name       text    not null check (char_length(name) between 1 and 8),
  score      integer not null check (score between 0 and 60000),
  lv         integer not null check (lv between 1 and 256),
  win        boolean not null default false,
  hero       integer not null check (hero between 0 and 9),
  created_at timestamptz not null default now()
);

create index if not exists scores_score_idx on public.scores (score desc);

alter table public.scores enable row level security;

-- 任何人可以读榜单
create policy "scores are readable by everyone"
  on public.scores for select
  to anon
  using (true);

-- 任何人可以提交成绩（只能新增，不能改、不能删）
create policy "anyone can submit a score"
  on public.scores for insert
  to anon
  with check (true);
