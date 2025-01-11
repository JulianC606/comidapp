-- db/production_setup.sql
CREATE ROLE wudc WITH CREATEDB LOGIN PASSWORD 'UnP4N4M4Kh3D3b4t3';
CREATE DATABASE lunches_production;
CREATE DATABASE lunches_production_cache;
CREATE DATABASE lunches_production_queue;
CREATE DATABASE lunches_production_cable;