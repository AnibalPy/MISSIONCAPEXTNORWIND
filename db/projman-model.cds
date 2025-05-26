using {
    cuid,
    sap
} from '@sap/cds/common';

namespace sfsf.projman.model.db;

entity Project : cuid, {
    name        : String(128);
    description : String(1024);
    startDate   : Date;
    endDate     : Date;
    status      : Association to one Status;
    team        : Composition of many Member
                      on team.parent = $self;
    activities  : Composition of many Activity
                      on activities.parent = $self;
}

entity Member : cuid {
    parent        : Association to one Project;
    member        : Association to one Employee;
    role          : Association to one Role;
    hasAssignment : Boolean default false;
}

entity Activity : cuid {
    parent      : Association to one Project;
    assignedTo  : Association to one Member;
    name        : String(128);
    description : String(1024);
    dueDate     : Date;
    status      : Association to one Status;
}

@readonly
@cds.autoexpose
entity Employee: cuid {
    key EmployeeID      : String(100);
        LastName        : String(100);
        FirstName       : String;
        Title           : String;
        TitleOfCourtesy : String(128);
        Address         : String(128);
        City            : String(255);
}

@readonly
@cds.autoexpose
entity Role : sap.common.CodeList {
    key ID : Integer;
}

@readonly
@cds.autoexpose
entity Status : sap.common.CodeList {
    key ID          : Integer;
        criticality : Integer;
}
