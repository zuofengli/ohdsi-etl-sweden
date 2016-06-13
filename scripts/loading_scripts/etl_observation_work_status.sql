INSERT INTO cdm5.observation (
        person_id,
        observation_concept_id,
        value_as_concept_id,
        observation_date,
        observation_type_concept_id,
        observation_source_value,
        value_as_string
    )
SELECT  lpnr,
        4073163 as observation_concept_id, -- Employment Status

        CASE syssstat11
            WHEN 1 THEN 4076340 -- Employed
            WHEN 5 THEN 4251171 -- Unemployed
            WHEN 6 THEN 4251171 -- Unemployed
            ELSE 0 -- Not mappable
         END AS value_as_concept_id,

        to_date(year,'yyyy'),
        38000280 as observation_type_concept_id, -- Observation recorded from EHR
        'syssstat11' as observation_source_value,
        syssstat11 as value_as_string -- Maybe redundant
FROM bayer.lisa as lisa
-- ONLY persons that are present in the person table! Otherwise foreign key constraint fails.
INNER JOIN cdm5.person as person ON person.person_id = lisa.lpnr
;