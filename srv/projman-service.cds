using sfsf.projman.model.db as model from '../db/projman-model';
using NorthwindService as external from '../srv/external/NorthwindService';

namespace sfsf.projman.service;

service ProjectManager @(path : '/projman') {
    @odata.draft.enabled
    entity Project as projection on model.Project;

    entity Member as
        select from model.Member {
            * ,
            member.FirstName as member_name
        };

    entity Activity as projection on model.Activity;

    @readonly
    entity SFSF_User as
        select from external.Employees {
            key EmployeeID,
                LastName,
                FirstName,
                Title,
                TitleOfCourtesy,
                Address,
                City
        };

    annotate SFSF_User with @(cds.odata.valuelist);
}
