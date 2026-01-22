using { Currency, managed,cuid , sap } from '@sap/cds/common';

namespace migration;



type WaveStatus : String enum {

    YET_TO_START;
    IN_PROGRESS;
    COMPLETED;
    ON_HOLD;
}

type RagStatus : String enum {
  R;
  A;
  G;
}

type UserRole  : String enum {
    ADMIN;
    USER;
    GUEST;
}


entity Waves @(cds.persistence.name: 'Waves') : cuid ,managed{

  key ID               : Integer @cds.persistence.auto;

  name                 : String(30);

  startDate            : Date;
  endDate              : Date;
  actualStartDate      : Date;
  actualEndDate        : Date;

  status               : WaveStatus;
  rag                  : RagStatus;
  completionPercent    : Integer  @assert.range: [0,100];

  createdAt            : Timestamp;
  createdBy            : String(12);

  lastModifiedAt       : Timestamp;
  lastModifiedBy       : String(12);

  modifiedAt           : Timestamp;
  modifiedBy           : String(255);

  rollouts             : Composition of many Rollouts
                           on rollouts.waves = $self;


}


entity Rollouts @(cds.persistence.name: 'Rollouts') : managed {

  key ID               : Integer @cds.persistence.auto;
  waves                : Association to Waves;
  name                 : String(30);
  status               : WaveStatus;
  rag                  : RagStatus;
  completionPercent    : Integer;
  startDate            : Date;
  endDate              : Date;
  actualStartDate      : Date;
  actualEndDate        : Date;
  goLivePlannedDate    : Date;
  goLiveEndDate        : Date;
  reason               : String(100);
  openBlockers         : String(100);
  createdAt            : Timestamp;
  createdBy            : String(12);
  lastModifiedAt       : Timestamp;
  lastModifiedBy       : String(12);
  modifiedAt           : Timestamp;
  modifiedBy           : String(255);
  mocks : Composition of many Mocks
          on mocks.rollouts = $self;

}


entity Mocks @(cds.persistence.name: 'Mocks') : managed {
  key ID               : Integer @cds.persistence.auto;
  rollouts             : Association to Rollouts;
  name                 : String(20);
  owner                : String(12);
  startDate            : Date;
  endDate              : Date;
  actualStartDate      : Date;
  actualEndDate        : Date;
  status               : WaveStatus;
  rag                  : RagStatus;
  completionPercent    : Integer;
  createdAt            : Timestamp;
  createdBy            : String(12);
  lastModifiedAt       : Timestamp;
  lastModifiedBy       : String(12);
  mockstreams           : Composition of many MockStream
                        on mockstreams.mock = $self

}


entity Streams @(cds.persistence.name: 'Streams') : managed{
  key id           : Integer @cds.persistence.auto;
  name             : String(30);
  description      : String(255);
  mock_Id           : Integer;
  mockStreams : Composition of many MockStream
                on mockStreams.stream = $self;
}


entity MockStream @(cds.persistence.name: 'Mockstream') : managed {
  key mockStreamId      : Integer @cds.persistence.auto;
  mock                 : Association to Mocks;
  stream              : Association to Streams;
  notes                 : String(100);
  startDate             : Date;
  endDate               : Date;
  actualStartDate       : Date;
  actualEndDate         : Date;
  status                : WaveStatus;
  rag                   : String(255);
  createdAt             : Timestamp;
  createdBy             : String(12);
  lastModifiedAt        : Timestamp;
  lastModifiedBy        : String(12);
  
  objects : Composition of many MockStreamObjects
            on objects.mockStreams = $self;
}


entity Objects @(cds.persistence.name: 'Objects') : managed {

  key id           : Integer @cds.persistence.auto;

  name             : String(50);
  description      : String(255);

  stream           : Association to Streams
                       @cds.persistence.name: 'stream_id';
 
  mockStreams : Composition of many MockStreamObjects
                on mockStreams.object = $self;

 
}


entity MockStreamObjects @(cds.persistence.name: 'MockStreamObjects') : managed  {

  key mockStreams       : Association to MockStream ;
  key object            : Association to Objects;

  datatype              : String(255);
  extractionMeth        : String(255);
  transformationMeth    : String(255);
  loadingMeth           : String(255);

  totalRecords          : Integer;
  records_Loaded         : Integer;

  remarks               : String(100);

  startDate             : Date;
  endDate               : Date;
  actualStartDate       : Date;
  actualEndDate         : Date;

  status                : WaveStatus;
  rag                   : String(255);

  createdAt             : Timestamp;
  createdBy             : String(12);

  lastModifiedAt        : Timestamp;
  lastModifiedBy        : String(12);
}

entity Users  @(cds.persistence.name: 'Users'): managed {
    key ID       : Integer @cds.autoIncrement;
    username     : String(50) @mandatory @assert.unique;
    password     : String(255) @mandatory;
    email        : String(100);
    roles        : UserRole;
    active       : Boolean;
}

action login(username: String, password: String) returns Boolean;